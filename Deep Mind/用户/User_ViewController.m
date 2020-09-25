//
//  User_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/23.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "User_ViewController.h"
#import "InformationChange_ViewController.h"
#import "Login_ViewController.h"
#import "Register_ViewController.h"
#import "Budget_ViewController.h"
#import "Category_ViewController.h"
@interface User_ViewController ()
#define click_change true
@end

@implementation User_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *bar = self.navigationController.navigationBar;//导航栏背景色
    bar.barTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    //self.navigationController.
    
    self.view.backgroundColor = [self colorWithHexString:@"F9F9F9" alpha:1.0f];//视图背景色
    UIBarButtonItem *Set = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Set.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(set_click)];
    [self.navigationItem setRightBarButtonItem:Set animated:YES];
    
    UIView *use_background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 376, 200)];//用户背景图
    use_background.backgroundColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    [self.view addSubview:use_background];
    
    UIImageView *Photo = [[UIImageView alloc]initWithFrame:CGRectMake(146, 35, 80, 80)];//用户头像
    Photo.image = [UIImage imageNamed:@"i.png"];
    [use_background addSubview:Photo];
    
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(136, 140, 100, 20)];//用户昵称
    if (_state == true || _fresh_state == true) {
        Name.text = _username;//用户名传值
    }else{
        Name.text = @"亦灿";
    }
    Name.textColor = [UIColor whiteColor];//用户昵称字体颜色
    Name.textAlignment = UITextAlignmentCenter;//标签的文本内容居中对齐
    
    
    [use_background addSubview:Name];
    
    UILabel *Phone_numbers =[[UILabel alloc]initWithFrame:CGRectMake(126, 170, 30, 15)];//用户tel标签
    Phone_numbers.text = @"tel:";
    Phone_numbers.textColor = [UIColor whiteColor];//用户tel标签字体颜色
    UILabel *phone_numbers = [[UILabel alloc]initWithFrame:CGRectMake(156, 170, 110, 15)];//用户电话号标签
    if (_fresh_state == true) {
        phone_numbers.text = self->_tel;
    }else{
        phone_numbers.text = @"13527359420";
    }
    phone_numbers.textColor = [UIColor whiteColor];//用户电话号标签颜色
    [use_background addSubview:phone_numbers];
    [use_background addSubview:Phone_numbers];
    
    UIView *count_background = [[UIView alloc]initWithFrame:CGRectMake(30, 216, 312, 60)];//记账背景图
    count_background.backgroundColor = [UIColor whiteColor];
    count_background.layer.cornerRadius = 15.0;
    [self.view addSubview:count_background];
    UIImageView *string = [[UIImageView alloc]initWithFrame:CGRectMake(132, 15, 53, 30)];
    string.image = [UIImage imageNamed:@"string.png"];
    [count_background addSubview:string];
    
    UILabel *Bill_count = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 80, 20)];//记账笔数
    Bill_count.text = @"想买笔数";
    Bill_count.textColor = [UIColor blackColor];
    UILabel *bill_count = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 50, 30)];
    bill_count.text = @"13";
    bill_count.textColor = [UIColor blackColor];
    bill_count.font = [UIFont systemFontOfSize:30];
    [count_background addSubview:bill_count];
    [count_background addSubview:Bill_count];
    
    UILabel *Save_count = [[UILabel alloc]initWithFrame:CGRectMake(180, 20, 80, 20)];
    Save_count.text = @"省钱笔数";//省钱笔数
    Save_count.textColor = [UIColor blackColor];
    UILabel *save_count = [[UILabel alloc]initWithFrame:CGRectMake(260, 15, 50, 30)];
    save_count.text = @"02";
    save_count.textColor = [UIColor blackColor];
    save_count.font = [UIFont systemFontOfSize:30];
    [count_background addSubview:save_count];
    [count_background addSubview:Save_count];
    
    self->TableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 286, 355, 567) style:(UITableViewStyleGrouped)];
    TableView.backgroundColor = [UIColor whiteColor];
    TableView.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
    TableView.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    TableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);//设置第一组cell的导航栏的距离
    TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [TableView setDataSource:self];
    [TableView setDelegate:self];
    [self.view addSubview:TableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 4;
    }else
        return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    int section = indexPath.section;
    int row = indexPath.row;
    static NSString *CellIdentifier = @"???";
    Cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    if (Cell == nil){
        Cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];
        Cell.layer.cornerRadius = 9.0f;
        Cell.textColor = [UIColor blackColor];
        Cell.backgroundColor = [UIColor whiteColor];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //Cell.selectedTextColor = [self colorWithHexString:@"BFE5FA" alpha:0.5];
        
        switch (section) {
            case 0:
                switch (row) {
                    case 0:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"预算";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                        
                     case 1:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"类别";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                     case 2:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"编辑资料";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                      case 3:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"使用手册";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;

                    default:
                        break;
                }
                break;
            case 1:
                switch (row) {
                        case 0:
                            Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        if (_state == true) {
                            Cell.textLabel.text = @"退出登陆";
                            }else{
                            Cell.textLabel.text = @"登陆";
                            }
                            Cell.accessoryType = UITableViewCellAccessoryNone;
                            break;

                        default:
                            break;
                }
                break;
                default:
                break;
        }
    }
    return Cell;
}

//设置某一个row对应的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Budget_ViewController *budget = [[Budget_ViewController alloc]init];
    Category_ViewController *cate = [[Category_ViewController alloc]init];
    Register_ViewController *reg = [[Register_ViewController alloc]init];
    InformationChange_ViewController *infor = [[InformationChange_ViewController alloc]init];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:budget animated:YES];
                    break;
                    
                case 1:
                    [self.navigationController pushViewController:cate animated:YES];
                break;
                    
                case 2:
                    infor.username = self->_username;
                    [self.navigationController pushViewController:infor animated:YES ];
                    ;
                break;
                    
                case 3:
                    ;
                break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:reg animated:YES];
            }
            
            break;
        default:
            break;
    }
}

- (void)set_click{
    if (self->_click_state == true) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        InformationChange_ViewController *infor = [[InformationChange_ViewController alloc]init];
        infor.username = self->_username;
        [self.navigationController pushViewController:infor animated:YES ];
        infor.state = _state;
        self->_click_state = true;
    }
}

- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {//十六进制色号自定义颜色
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
    NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];
    
    if (match == 0) {return [UIColor clearColor];}
    
    NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
    BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
    BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (rValue && gValue && bValue) {
        return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
    } else {
        return [UIColor clearColor];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
