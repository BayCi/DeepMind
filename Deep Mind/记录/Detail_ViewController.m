//
//  Detail_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/10/14.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Detail_ViewController.h"

@interface Detail_ViewController ()

@end

@implementation Detail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详细记录";//导航栏title
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏title颜色
    self.view.backgroundColor = [self colorWithHexString:@"F9F9F9" alpha:1.0f];//视图背景色
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];//返回按钮
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];//返回按钮颜色
    [self.navigationController.navigationBar setBackgroundColor:[UIColor yellowColor]];
    
    UIImageView *Commodity_image = [[UIImageView alloc]initWithFrame:CGRectMake(150, 90, 75, 75)];//商品图片
    Commodity_image.backgroundColor = [UIColor whiteColor];
    Commodity_image.image = [UIImage imageNamed:@"commodity.png"];
    [self.view addSubview:Commodity_image];
    
    self->tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 180, 375, 567) style:(UITableViewStyleGrouped)];
    tableView.backgroundColor = [UIColor whiteColor];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    tableView.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
    tableView.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);//设置第一组cell的导航栏的距离
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [self.view addSubview:tableView];
    
    UIButton *Delete = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    Delete.frame = CGRectMake(150, 430, 75, 30);
    Delete.layer.cornerRadius = 8.0f;
    [Delete setTitle:@"删除" forState:(UIControlStateNormal)];
    [Delete setBackgroundColor:[self colorWithHexString:@"F2C200" alpha:1.0f]];
    [Delete setTintColor:[UIColor whiteColor]];
    [self->tableView addSubview:Delete];
    [Delete addTarget:self action:@selector(delete) forControlEvents:(UIControlEventTouchUpInside)];
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
        return 2;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    edit = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"edit.png"]];
    int section = indexPath.section;
    int row = indexPath.row;
    static NSString *CellIdentifier = @"???";
    Cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    if (Cell == nil){
        Cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];
        Cell.textColor = [UIColor blackColor];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Cell.backgroundColor = [UIColor whiteColor];
        
        switch (section) {
            case 0:
                switch (row) {
                    case 0:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"衣服穿搭";
                        Cell.imageView.image = [UIImage imageNamed:@"0.png"];
                        Cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                        Cell.accessoryView = edit;
                        break;
                        
                     case 1:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"心动";
                        Cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                        Cell.accessoryView = edit;
                        break;
                     case 2:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"使用时长";
                        Cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                        Cell.accessoryView = edit;
                        break;
                      case 3:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"了解程度";
                        Cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                        Cell.accessoryView = edit;
                        break;

                    default:
                        break;
                }
                break;
            case 1:
                switch (row) {
                        case 0:
                            Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                            Cell.textLabel.text = @"等等说：你上次...评分为 90%";
                            Cell.accessoryType = UITableViewCellAccessoryNone;
                            break;
                            
                         case 1:
                            Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                            Cell.textLabel.text = @"您暂未二次评定";
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
    if (indexPath.section == 1) {
        return 70;
    }else
        return 50;
}

- (void)delete{
    [self.navigationController popViewControllerAnimated:self];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:self];
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

@end
