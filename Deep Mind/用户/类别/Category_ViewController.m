//
//  Category_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/28.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Category_ViewController.h"
#import "ExpandCell.h"
#define kCell_Height 55   //单元格cell的高度
@interface Category_ViewController ()

@end

@implementation Category_ViewController

- (void)initDataSource
{
    sectionArray  = [NSMutableArray arrayWithObjects:@"衣物搭配",
                     @"食品",
                     @"出行居住",
                     @"运动健身",@"兴趣娱乐",@"数码产品",@"其他",nil];
    
    NSArray *one = @[@"饰品",@"女装",@"男装",@"鞋靴",@"内衣",@"化妆品"];
    NSArray *two = @[@"零食",@"乳饮",@"方便速食",@"茶酒",@"保健"];
    NSArray *three = @[@"箱包",@"电器",@"家具"];
    NSArray *four = @[@"运动穿搭",@"运动器材",@"球类",@"保健卡"];
    NSArray *five = @[@"游戏",@"乐器",@"收藏",@"小说",@"票卷"];
    NSArray *six = @[@"手机",@"电脑",@"数码配件",@"手表",@"相机"];
    NSArray *seven = @[@"其他"];
    
    dataSource = [NSMutableArray arrayWithObjects:one,two,three,four,five,six,seven, nil];
    stateArray = [NSMutableArray array];
    
    for (int i = 0; i < dataSource.count; i++)
    {
        //所有的分区都是闭合
        [stateArray addObject:@"0"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];//视图背景色
    self.title = @"类别";//导航栏title
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏title颜色
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];//左返回按钮
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];//返回按钮颜色
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(add)];//右添加按钮
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];//添加按钮颜色
    [self initDataSource];
    [self initTable];
}

- (void)back{
    //User_ViewController *user = [[self.navigationController viewControllers]objectAtIndex:1];
    [self.navigationController popViewControllerAnimated:self];
}

- (void)add{
    NSLog(@"add succeesful!");
}

-(void)initTable{
    expandTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    expandTable.backgroundColor = [UIColor whiteColor];
    expandTable.rowHeight = 50;
    expandTable.sectionHeaderHeight = 4.0f;//设置每个cell的上间距
    expandTable.sectionFooterHeight = 4.0f;//设置每个cell的下间距
    expandTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置第一组cell的导航栏的距离
    expandTable.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    
    expandTable.dataSource = self;
    expandTable.delegate =  self;
    expandTable.tableFooterView = [UIView new];
    [expandTable registerNib:[UINib nibWithNibName:@"ExpandCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:expandTable];
    
}
#pragma mark -
#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSArray *array = [dataSource objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.listLabel.textAlignment = NSTextAlignmentLeft;
    cell.listLabel.text = dataSource[indexPath.section][indexPath.row];
    //cell.listLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionArray[section];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:line];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (kCell_Height-22)/2, 28, 28)];
    switch (section) {
        case 0:
            [imgView setImage:[UIImage imageNamed:@"0.png"]];
            break;
        case 1:
            [imgView setImage:[UIImage imageNamed:@"1.png"]];
            break;
        case 2:
            [imgView setImage:[UIImage imageNamed:@"2.png"]];
            break;
        case 3:
            [imgView setImage:[UIImage imageNamed:@"3.png"]];
            break;
        case 4:
            [imgView setImage:[UIImage imageNamed:@"4.png"]];
            break;
        case 5:
            [imgView setImage:[UIImage imageNamed:@"5.png"]];
            break;
        case 6:
            [imgView setImage:[UIImage imageNamed:@"6.png"]];
            break;
        default:
            break;
    }
//    [imgView setImage:[UIImage imageNamed:@"ico_faq_d"]];//cell的图标
    [button addSubview:imgView];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (kCell_Height-6)/2, 12, 10)];
    
    if ([stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, (kCell_Height-20)/2, 200, 20)];
    tlabel.textColor = [UIColor blackColor];//设置大类别的字体颜色
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:sectionArray[section]];
    [button addSubview:tlabel];
    return button;
}
#pragma mark
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [expandTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCell_Height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
