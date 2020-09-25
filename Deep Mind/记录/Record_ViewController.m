//
//  Record_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/23.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Record_ViewController.h"
#import "Detail_ViewController.h"
@interface Record_ViewController ()

@end

@implementation Record_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar *bar = self.navigationController.navigationBar;//导航栏背景色
    bar.barTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    
    self->tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 375, 567) style:(UITableViewStyleGrouped)];
    tableView1.backgroundColor = [UIColor whiteColor];
//    tableView1.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
//    tableView1.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    tableView1.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);//设置第一组cell的导航栏的距离
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [tableView1 setDataSource:self];
    [tableView1 setDelegate:self];
    
    self->tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 375, 567) style:(UITableViewStyleGrouped)];
    tableView2.backgroundColor = [UIColor whiteColor];
//    tableView2.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
//    tableView2.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    tableView2.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);//设置第一组cell的导航栏的距离
    tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [tableView2 setDataSource:self];
    [tableView2 setDelegate:self];
    
    self->tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 375, 567) style:(UITableViewStyleGrouped)];
    tableView3.backgroundColor = [UIColor whiteColor];
//    tableView3.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
//    tableView3.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    tableView3.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);//设置第一组cell的导航栏的距离
    tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [tableView3 setDataSource:self];
    [tableView3 setDelegate:self];
    
    [self.view addSubview:tableView1];
    
    self.title = @"记录";
    NSArray *items = @[@"总览",@"剁手",@"放弃"];
    UISegmentedControl *segmented = [[UISegmentedControl alloc]initWithItems:items];
    segmented.frame = CGRectMake(60, 90, 255, 30);
    segmented.segmentedControlStyle = UISegmentedControlStyleBar;
    [segmented setWidth:85.0f forSegmentAtIndex:1];
    segmented.selectedSegmentTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    [segmented setSelectedSegmentIndex:0];
    [segmented addTarget:self action:@selector(value:) forControlEvents:UIControlEventValueChanged];
    //[self.navigationItem setTitleView:segmented];
    [self.view addSubview:segmented];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0 || section == 1){
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    int row = indexPath.row;
    static NSString *CellIdentifier = @"nationality";
    UITableViewCell *cell1 = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell1 == nil) {
        cell1 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];
        cell1.textLabel.font = [UIFont fontWithName:@"Marin" size:20];
        cell1.textColor = [UIColor blackColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor whiteColor];
        switch (section) {
                case 0:
                switch(row){
                    case 0:
                        cell1.textLabel.text = @"衣物穿搭";
                        cell1.imageView.image = [UIImage imageNamed:@"0.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                    case 1:
                        cell1.textLabel.text = @"食品";
                        cell1.imageView.image = [UIImage imageNamed:@"1.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                    case 2:
                        cell1.textLabel.text = @"出行居住";
                        cell1.imageView.image = [UIImage imageNamed:@"2.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                }
                break;
                
                case 1:
                switch (row) {
                    case 0:
                        cell1.textLabel.text = @"运动健身";
                        cell1.imageView.image = [UIImage imageNamed:@"3.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                        
                    case 1:
                        cell1.textLabel.text = @"兴趣娱乐";
                        cell1.imageView.image = [UIImage imageNamed:@"4.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                    case 2:
                        cell1.textLabel.text = @"数码产品";
                        cell1.imageView.image = [UIImage imageNamed:@"5.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                }
                break;
                
                case 2:
                switch (row) {
                    case 0:
                        cell1.textLabel.text = @"其他";
                        cell1.imageView.image = [UIImage imageNamed:@"6.png"];
                        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell1.detailTextLabel.text = @"0";
                        break;
                }
                break;
        }
    }
    
    UITableViewCell *cell2 = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell2 == nil){
        cell2 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:(CellIdentifier)];
        cell2.textLabel.font = [UIFont fontWithName:@"Marin" size:20];
        cell2.textColor = [UIColor blackColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor whiteColor];

        switch (section){
            case 0:
                switch(row){
                    case 0:
                        cell2.textLabel.text = @"衣物穿搭";
                        cell2.imageView.image = [UIImage imageNamed:@"0.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                    case 1:
                        cell2.textLabel.text = @"食品";
                        cell2.imageView.image = [UIImage imageNamed:@"1.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                    case 2:
                        cell2.textLabel.text = @"出行居住";
                        cell2.imageView.image = [UIImage imageNamed:@"2.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                    case 3:
                        cell2.textLabel.text = @"运动健身";
                        cell2.imageView.image = [UIImage imageNamed:@"3.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                    case 4:
                        cell2.textLabel.text = @"兴趣娱乐";
                        cell2.imageView.image = [UIImage imageNamed:@"4.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                    case 5:
                        cell2.textLabel.text = @"数码产品";
                        cell2.imageView.image = [UIImage imageNamed:@"5.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                    case 6:
                        cell2.textLabel.text = @"其他";
                        cell2.imageView.image = [UIImage imageNamed:@"6.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"0";
                        break;
                }
                break;
        }
    }
    
    UITableViewCell *cell3 = [tableView3 dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell3 == nil){
        cell3 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];
        cell3.textLabel.font = [UIFont fontWithName:@"Marin" size:20];
        cell3.textColor = [UIColor blackColor];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.backgroundColor = [UIColor whiteColor];

        switch (section){
            case 0:
                switch(row){
                    case 0:
                        cell3.textLabel.text = @"衣物穿搭";
                        cell3.imageView.image = [UIImage imageNamed:@"0.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"0";
                        break;
                    case 1:
                        cell3.textLabel.text = @"食品";
                        cell3.imageView.image = [UIImage imageNamed:@"1.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"0";
                        break;
                    case 2:
                        cell3.textLabel.text = @"出行居住";
                        cell3.imageView.image = [UIImage imageNamed:@"2.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"0";
                        break;
                    case 3:
                        cell3.textLabel.text = @"运动健身";
                        cell3.imageView.image = [UIImage imageNamed:@"3.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"105";
                        break;
                    case 4:
                        cell3.textLabel.text = @"兴趣娱乐";
                        cell3.imageView.image = [UIImage imageNamed:@"4.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"0";
                        break;
                    case 5:
                        cell3.textLabel.text = @"数码产品";
                        cell3.imageView.image = [UIImage imageNamed:@"5.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"0";
                        break;
                    case 6:
                        cell3.textLabel.text = @"其他";
                        cell3.imageView.image = [UIImage imageNamed:@"6.png"];
                        cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell3.detailTextLabel.text = @"0";
                        break;
                }
                break;
        }
    }
    if (tableView == tableView1) {
        return cell1;
    } else if (tableView == tableView2) {
        return cell2;
    } else {
        return cell3;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Detail_ViewController *detail = [[Detail_ViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    [detail.navigationItem setHidesBackButton:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"09月08日";
            break;
        case 1:
            return @"09月07日";
        case 2:
            return @"09月06日";
        default:
            return 0;
    }
}

- (void)value:(UISegmentedControl *)segmented{
    
    
    
    switch (segmented.selectedSegmentIndex) {
        case 0:
            [self.view addSubview:tableView1];
            break;
            
        case 1:
            [self.view addSubview:tableView2];
            break;
            
        case 2:
            [self.view addSubview:tableView3];
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"This is United Kindom " delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
    [alertView show];
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
