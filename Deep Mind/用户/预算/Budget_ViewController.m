//
//  Budget_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/27.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Budget_ViewController.h"

@interface Budget_ViewController ()

@end

@implementation Budget_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];//视图背景色
    self.title = @"预算";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];//返回按钮
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];//返回按钮颜色
    [self.navigationController.navigationBar setBackgroundColor:[UIColor yellowColor]];

    self->tableView1.estimatedRowHeight = segmented.frame.size.height+30;
    self->tableView2.estimatedRowHeight = segmented.frame.size.height+30;
    
    self->tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 375, 567) style:(UITableViewStyleGrouped)];//本月预算
    tableView1.backgroundColor = [UIColor whiteColor];
    tableView1.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
    tableView1.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    tableView1.contentInset = UIEdgeInsetsMake(-45, 0, 0, 0);//设置第一组cell的导航栏的距离
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [tableView1 setDataSource:self];
    [tableView1 setDelegate:self];
    [self.view addSubview:tableView1];
//
    self->tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 375, 567) style:(UITableViewStyleGrouped)];//常规预算
    tableView2.backgroundColor = [UIColor whiteColor];
    tableView2.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
    tableView2.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    tableView2.contentInset = UIEdgeInsetsMake(-45, 0, 0, 0);//设置第一组cell的导航栏的距离
    tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    [tableView2 setDataSource:self];
    [tableView2 setDelegate:self];
    [self.view addSubview:tableView2];
    
    NSArray *items = @[@"常规预算",@"本月预算"];
    segmented = [[UISegmentedControl alloc]initWithItems:items];
    segmented.frame = CGRectMake(102.5, 90, 170, 35);
    segmented.segmentedControlStyle = UISegmentedControlStyleBar;
    segmented.selectedSegmentTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    [segmented setWidth:85.0f forSegmentAtIndex:1];
    [segmented setSelectedSegmentIndex:0];
    [segmented addTarget:self action:@selector(value:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];
    
    tableView1.rowHeight = 50;
    tableView2.rowHeight = 50;
    
    
}

- (void)back{
    //User_ViewController *user = [[self.navigationController viewControllers]objectAtIndex:1];
    [self.navigationController popViewControllerAnimated:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = (indexPath.section);
    int row = indexPath.row;
    static NSString *CellIdentifier = @"nationality";
    UITableViewCell *cell1 = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell1 == nil) {
        cell1 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];//本月预算
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
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                    case 1:
                        cell1.textLabel.text = @"食品";
                        cell1.imageView.image = [UIImage imageNamed:@"1.png"];
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                    case 2:
                        cell1.textLabel.text = @"出行居住";
                        cell1.imageView.image = [UIImage imageNamed:@"2.png"];
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                    case 3:
                        cell1.textLabel.text = @"运动健身";
                        cell1.imageView.image = [UIImage imageNamed:@"3.png"];
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                    case 4:
                        cell1.textLabel.text = @"兴趣娱乐";
                        cell1.imageView.image = [UIImage imageNamed:@"4.png"];
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                    case 5:
                        cell1.textLabel.text = @"数码产品";
                        cell1.imageView.image = [UIImage imageNamed:@"5.png"];
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                    case 6:
                        cell1.textLabel.text = @"其他";
                        cell1.imageView.image = [UIImage imageNamed:@"6.png"];
                        cell1.accessoryType = UITableViewCellAccessoryNone;
                        cell1.detailTextLabel.text = @"¥0";
                        break;
                }
                break;
        }
    }
    
    UITableViewCell *cell2 = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];//常规预算
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
                        cell2.detailTextLabel.text = @"饰品";
                        break;
                    case 1:
                        cell2.textLabel.text = @"食品";
                        cell2.imageView.image = [UIImage imageNamed:@"1.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"零食";
                        break;
                    case 2:
                        cell2.textLabel.text = @"出行居住";
                        cell2.imageView.image = [UIImage imageNamed:@"2.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"箱包";
                        break;
                    case 3:
                        cell2.textLabel.text = @"运动健身";
                        cell2.imageView.image = [UIImage imageNamed:@"3.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"运动穿搭";
                        break;
                    case 4:
                        cell2.textLabel.text = @"兴趣娱乐";
                        cell2.imageView.image = [UIImage imageNamed:@"4.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"小说";
                        break;
                    case 5:
                        cell2.textLabel.text = @"数码产品";
                        cell2.imageView.image = [UIImage imageNamed:@"5.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell2.detailTextLabel.text = @"手机";
                        break;
                    case 6:
                        cell2.textLabel.text = @"其他";
                        cell2.imageView.image = [UIImage imageNamed:@"6.png"];
                        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        //cell2.detailTextLabel.text = @"购物";
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
        return cell1;
    }
    
}

- (void)value:(UISegmentedControl *)segmented{
    
    switch (segmented.selectedSegmentIndex) {
        case 0:
            [self.view addSubview:tableView2];
            break;
            
        case 1:
            [self.view addSubview:tableView1];
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertAction *one;
    UIAlertAction *two;
    UIAlertAction *three;
    UIAlertAction *four;
    UIAlertAction *five;
    UIAlertAction *six;
    UIAlertAction *seven;
    
    UIAlertController *choose = [UIAlertController alertControllerWithTitle:@"请选择：" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    //choose.view.backgroundColor = [UIColor whiteColor];
    choose.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_value = [UIAlertController alertControllerWithTitle:@"请输入金额：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_value.view.backgroundColor = [UIColor whiteColor];
    change_value.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_detail = [UIAlertController alertControllerWithTitle:@"请输入：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_detail.view.backgroundColor = [UIColor whiteColor];
    change_detail.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSArray *let;
        switch (self->segmented.selectedSegmentIndex) {
            case 0:
                let = change_detail.textFields;
                break;
            case 1:
                let = change_value.textFields;
                break;
            default:
                break;
        }
        UITextField *field = let[0];
        
        if (self->segmented.selectedSegmentIndex == 0) {
            NSLog(@"当前的segmented的选择值为：%ld",(long)self->segmented.selectedSegmentIndex);
            [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text =
            field.text;
        }else{
            NSLog(@"当前的segmented的选择值为：%ld",(long)self->segmented.selectedSegmentIndex);
            [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text =
            [NSString stringWithFormat:@"¥%@",field.text];
            self->_var += [field.text intValue];
            self->_budget_amount = [NSString stringWithFormat:@"%d",self->_var];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeValueNotification" object:self->_budget_amount];
            
        }
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:(@"取消") style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    if (self->segmented.selectedSegmentIndex == 0) {
        switch (indexPath.row) {
            case 0:{
                one = [UIAlertAction actionWithTitle:@"饰品" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"饰品";
                 }];
                two  = [UIAlertAction actionWithTitle:@"女装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"女装";
                 }];
                 three  = [UIAlertAction actionWithTitle:@"男装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"男装";
                 }];
                 four  = [UIAlertAction actionWithTitle:@"鞋靴" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"鞋靴";
                 }];
                 five  = [UIAlertAction actionWithTitle:@"内衣" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"内衣";
                 }];
                 six  = [UIAlertAction actionWithTitle:@"化妆品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"化妆品";
                 }];
            }
                break;

            case 1:{
                one = [UIAlertAction actionWithTitle:@"零食" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"零食";
                 }];
                two  = [UIAlertAction actionWithTitle:@"乳饮" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"乳饮";
                 }];
                 three  = [UIAlertAction actionWithTitle:@"方便速食" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"方便速食";
                 }];
                 four  = [UIAlertAction actionWithTitle:@"茶酒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"茶酒";
                 }];
                 five  = [UIAlertAction actionWithTitle:@"保健" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"保健";
                 }];
            }
            break;

            case 2:{
                one = [UIAlertAction actionWithTitle:@"箱包" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"箱包";
                 }];
                two  = [UIAlertAction actionWithTitle:@"电器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"电器";
                 }];
                 three  = [UIAlertAction actionWithTitle:@"家具" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"家具";
                 }];
            }
            break;

            case 3:{
                one = [UIAlertAction actionWithTitle:@"运动穿搭" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"运动穿搭";
                 }];
                two  = [UIAlertAction actionWithTitle:@"运动器材" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"运动器材";
                 }];
                 three  = [UIAlertAction actionWithTitle:@"球类" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"球类";
                 }];
                 four  = [UIAlertAction actionWithTitle:@"健身卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"健身卡";
                 }];
            }
            break;

            case 4:{
                one = [UIAlertAction actionWithTitle:@"游戏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"游戏";
                 }];
                two  = [UIAlertAction actionWithTitle:@"乐器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"乐器";
                 }];
                 three  = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"收藏";
                 }];
                 four  = [UIAlertAction actionWithTitle:@"小说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"小说";
                 }];
                 five  = [UIAlertAction actionWithTitle:@"票卷" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"票卷";
                 }];
            }
            break;

            case 5:{
                one = [UIAlertAction actionWithTitle:@"手机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"手机";
                 }];
                two  = [UIAlertAction actionWithTitle:@"电脑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"电脑";
                 }];
                 three  = [UIAlertAction actionWithTitle:@"数码配件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"数码配件";
                 }];
                 four  = [UIAlertAction actionWithTitle:@"手表" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"手表";
                 }];
                 five  = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"相机";
                 }];
            }
            break;

            case 6:{
                one = [UIAlertAction actionWithTitle:@"其他" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"其他";
                }];
            }
            break;
            default:
                break;
        }
    }

    
    switch (self->segmented.selectedSegmentIndex) {
        case 0:
                    switch (indexPath.row) {
                case 0:
                    [choose addAction:one];
                    [choose addAction:two];
                    [choose addAction:three];
                    [choose addAction:four];
                    [choose addAction:five];
                    [choose addAction:six];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 1:
                    [choose addAction:one];
                    [choose addAction:two];
                    [choose addAction:three];
                    [choose addAction:four];
                    [choose addAction:five];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 2:
                    [choose addAction:one];
                    [choose addAction:two];
                    [choose addAction:three];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 3:
                    [choose addAction:one];
                    [choose addAction:two];
                    [choose addAction:three];
                    [choose addAction:four];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 4:
                    [choose addAction:one];
                    [choose addAction:two];
                    [choose addAction:three];
                    [choose addAction:four];
                    [choose addAction:five];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 5:
                    [choose addAction:one];
                    [choose addAction:two];
                    [choose addAction:three];
                    [choose addAction:four];
                    [choose addAction:five];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 6:
                    [choose addAction:one];
                    [choose addAction:cancel];
                    [self presentViewController:choose animated:YES completion:nil];
                    break;
                case 7:

                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 1:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 2:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 3:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 4:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 5:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 6:
                    [change_value addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        NSLog(@"输入");
                    }];
                    [change_value addAction:save];
                    [change_value addAction:cancel];
                    [self presentViewController:change_value animated:YES completion:nil];
                    break;
                case 7:

                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
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
