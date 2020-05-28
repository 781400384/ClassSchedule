//
//  UniverdsityListViewController.m
//  ClassSchedule
//
//  Created by Superme on 2019/11/4.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "UniverdsityListViewController.h"

#import "ClassHandle.h"
#import "SchoolModel.h"

#import "SinglePickerView.h"
#import "MajorsModel.h"
@interface UniverdsityListViewController ()<UITableViewDelegate,UITableViewDataSource,CSBaseTableViewDelegate>
@property (nonatomic, strong) CSBaseTableView    *     tableView;
//
@property (nonatomic, copy) NSDictionary *dataDic;
//
@property (nonatomic, copy) NSArray *sectionArray;

@property (nonatomic, strong) NSMutableArray     *     dataList;

@end

@implementation UniverdsityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self tableView];
    self.naviView.naviTitleLabel.text=@"选择学校";
    [self loadData];
    
}
-(void)loadData{
    [ClassHandle getSchoolListWithSuccess:^(id  _Nonnull obj) {
       
        NSDictionary  * dic=(NSDictionary *)obj;
        [self onjsonWithDictionary:dic];
        self.dataList=[SchoolModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"schools"]];
        [self tableView];
        [self.tableView reloadData];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(CSBaseTableView *)tableView{
    if (!_tableView) {
       CSBaseTableView * tableView = [[CSBaseTableView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH,SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
              tableView.delegate = self;
              tableView.dataSource = self;
              tableView.separatorInset = UIEdgeInsetsZero;
              tableView.separatorColor=RGB(244, 244, 244);
//              [tableView setRadius:34.5*KScaleW];
              tableView.backgroundColor=[UIColor whiteColor];;
              [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
              [self.view addSubview:tableView];
              _tableView=tableView;
        
    }
    return _tableView;
}


#pragma mark -- UITableViewDatasource --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     NSLog(@"%lu",(unsigned long)self.dataList.count);
    return self.dataList.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SchoolModel  *  model=self.dataList[indexPath.section];
    SchoolName    * nameModel=model.school[indexPath.row];
    [ClassHandle getSchoolListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary  * dic=(NSDictionary *)obj;
        NSMutableArray  *  list=[MajorsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"majors"]];
        NSMutableArray  *  array=[[NSMutableArray alloc]init];
        [array addObjectsFromArray:[list valueForKey:@"title"]];
                SinglePickerView    *     singleVC=[[SinglePickerView alloc]initWithComponentDataArray:array title:@"选择专业"];
                                    singleVC.getPickerValue = ^(NSString *compoentString) {
                      //                  [self.weekTF setText:compoentString];
                                        
//                                        if ([self.type isEqualToString:@"0"]) {
                                            
                                          
                                            if (self.SchoolBlock) {
                                                self.SchoolBlock(nameModel.id, nameModel.name, @"", compoentString);
                                            }
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                            
                                            
//                                        }
                                    };
                              
                 

              [self.view addSubview:singleVC];

       } failed:^(id  _Nonnull obj) {
           
       }];
    
    
   
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   SchoolModel  *  model=self.dataList[section];
  
    return model.school.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SchoolModel  *  model=self.dataList[indexPath.section];
    SchoolName    * nameModel=model.school[indexPath.row];

    cell.textLabel.text = nameModel.name;
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SchoolModel  *  model=self.dataList[section];

    return model.name;
}
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return self.dataList;
//}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//  
//    NSDictionary *dic = [self.dataList objectAtIndex:index];
//    
//    NSString *key = [dic allKeys][0];
//    NSLog(@"key==%@",dic);
//    if (key == UITableViewIndexSearch) {
//        
//        [self.tableView setContentOffset:CGPointZero animated:NO];
//        return NSNotFound;
//    }
//    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    return index;
//}
//



-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
- (void)onjsonWithDictionary:(NSDictionary *)dic

{

//    如果数组或者字典中存储了  NSString, NSNumber, NSArray, NSDictionary, or NSNull 之外的其他对象,就不能直接保存成文件了.也不能序列化成 JSON 数据.

//    NSDictionary *dic = dic;;

    

    // 1.判断当前对象是否能够转换成JSON数据.

    // YES if obj can be converted to JSON data, otherwise NO

    BOOL isYes = [NSJSONSerialization isValidJSONObject:dic];

    

    if (isYes) {

        NSLog(@"可以转换");

        

        /* JSON data for obj, or nil if an internal error occurs. The resulting data is a encoded in UTF-8.

         */

        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];

        

        /*

         Writes the bytes in the receiver to the file specified by a given path.

         YES if the operation succeeds, otherwise NO

         */

        // 将JSON数据写成文件

        // 文件添加后缀名: 告诉别人当前文件的类型.

        // 注意: AFN是通过文件类型来确定数据类型的!如果不添加类型,有可能识别不了! 自己最好添加文件类型.

//        [jsonData writeToFile:@"/Users/xyios/Desktop/dict.json" atomically:YES];

        //存入NSDocumentDirectory

        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;

        

        //创建文件夹

        NSString *patientPhotoFolder = [path stringByAppendingPathComponent:@"abdd"];

        NSFileManager *fileManager = [[NSFileManager alloc] init];

        [fileManager createDirectoryAtPath:patientPhotoFolder

               withIntermediateDirectories:NO

                                attributes:nil

                                     error:nil];

        //储存文件名称+格式

        NSString *savePath = [patientPhotoFolder stringByAppendingPathComponent:@"school.json"];

        NSLog(@"savePath is SY:%@",savePath);

        [jsonData writeToFile:savePath atomically:YES];

        

        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

        

    } else {

        

        NSLog(@"JSON数据生成失败，请检查数据格式");

        

    }

    

}


@end
