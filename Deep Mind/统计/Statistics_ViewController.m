//
//  Statistics_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/23.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "Statistics_ViewController.h"
#import "HXCharts.h"
@interface Statistics_ViewController ()
{
    HXRingChart *ring;
    HXCircleChart *circle;//扇形图
    HXLineChart *line;//折线图
}
@end

@implementation Statistics_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册一个改变值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeValue:) name:@"changeValueNotification" object:nil];
    
    self.navigationItem.title = @"统计";//导航栏title
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};//导航栏title颜色
    self.view.backgroundColor = [self colorWithHexString:@"F9F9F9" alpha:1.0f];//视图背景色

    UINavigationBar *bar = self.navigationController.navigationBar;//导航栏背景色
    bar.barTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    
    UIButton *Pandect = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];//总览按钮
    Pandect.frame = CGRectMake(15, 80, 50, 20);
    [Pandect setTitle:@"全部" forState:(UIControlStateNormal)];
    [Pandect setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [Pandect setFont:[UIFont fontWithName:@"OriyaSangamMN-Bold" size:27.0f]];
    Pandect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    Pandect.layer.cornerRadius = 10.0;
    Pandect.enabled = YES;
    [self.view addSubview:Pandect];
    [Pandect addTarget:self action:@selector(Pandect_click) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSArray *items = @[@"趋",@"扇"];
    UISegmentedControl *segmented = [[UISegmentedControl alloc]initWithItems:items];//分段按钮
    segmented.selectedSegmentTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];//分段按钮颜色
    segmented.frame = CGRectMake(277, 80, 80, 30);
    segmented.segmentedControlStyle = UISegmentedControlStyleBar;
    [segmented setWidth:40.0f forSegmentAtIndex:1];
    
    [segmented setSelectedSegmentIndex:0];//分段按钮的初始值为0
    [segmented addTarget:self action:@selector(value:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];//分段按钮的动作事件
    
    
    UIImageView *Wait_Tips = [[UIImageView alloc]initWithFrame:CGRectMake(10, 432, 352, 150)];//本月消费_等等说
    Wait_Tips.backgroundColor = [UIColor whiteColor];//等等说的视图背景颜色
    Wait_Tips.layer.cornerRadius = 20.0;//设置等等说的视图边角弧度
    
    UIImageView *Wait = [[UIImageView alloc]initWithFrame:CGRectMake(22, 444, 30, 30)];
    Wait.image = [UIImage imageNamed:@"Wait.png"];//Wait头像
    
    UILabel *Saying_label = [[UILabel alloc]initWithFrame:CGRectMake(55, 449, 80, 21)];
    Saying_label.text = @"等等说：";
    
    UILabel *Budget_thisMonth = [[UILabel alloc]initWithFrame:CGRectMake(22, 484, 87, 25)];
    Budget_thisMonth.text = @"本月预算：";
    Budget_thisMonth.textColor = [UIColor blackColor];
    Budget_content = [[UILabel alloc]initWithFrame:CGRectMake(105, 484, 75, 25)];
    Budget_content.text = @"2000";//本月消费内容
    Budget_content.textColor = [UIColor blackColor];
    [Budget_content setFont:[UIFont systemFontOfSize:25]];//设置本月消费内容标签的字体大小
    
    UILabel *Actual_consumption = [[UILabel alloc]initWithFrame:CGRectMake(196, 484, 87, 25)];
    Actual_consumption.text = @"实际消费：";
    Actual_consumption.textColor = [UIColor blackColor];
    Actual_content = [[UILabel alloc]initWithFrame:CGRectMake(279, 484, 75, 25)];
    Actual_content.text = @"1000";//实际消费内容
    [Actual_content setFont:[UIFont systemFontOfSize:25]];//设置实际消费内容标签的字体大小
    Actual_content.textColor = [UIColor redColor];
    
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(22, 514, 308, 50)];
    tips.text = @"        递归方法可以被用于解决很多的计算机科学问题，因此它是计算机科学中十分重要的一个概念。";
    tips.textColor = [UIColor blackColor];
    [tips setFont:[UIFont systemFontOfSize:13]];//设置tips标签的字体大小
    [tips setNumberOfLines:3];//设置tips标签的内容行数
    [tips sizeToFit];

    [self.view addSubview:Wait_Tips];
    [self.view addSubview:Wait];
    [self.view addSubview:Saying_label];
    [self.view addSubview:Budget_thisMonth];
    [self.view addSubview:Budget_content];
    [self.view addSubview:Actual_consumption];
    [self.view addSubview:Actual_content];
    [self.view addSubview:tips];
    
    [self line_init];//折线图初始化
}

-(void)line_init{//折线图初始化
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat lineChartWidth = self.view.frame.size.width * 0.95;
    CGFloat lineChartHeight = self.view.frame.size.height * 0.4;
    CGFloat lineChartX = (width - lineChartWidth) / 2 - 20;
    CGFloat lineChartY = (height - lineChartHeight) / 3;
    
    line = [[HXLineChart alloc] initWithFrame:CGRectMake(lineChartX, lineChartY, lineChartWidth, lineChartHeight)];
    [line setTitleArray:@[@"09.01",@"09.06",@"09.11",@"09.16",@"09.21",@"09.26",@"09.30"]];
    line.markTextColor = [UIColor blackColor];
    
    //[line setValue:@[@13,@30,@52,@73,@91,@34,@25] withYLineCount:6];
    [line setValue:@[@100,@200,@350,@600,@350,@200,@100] withYLineCount:11];//折线图的纵坐标赋值
    
    line.lineColor = [self colorWithHexString:@"#43befa" alpha:1];
    //#2e3f53
    line.fillColor = [self colorWithHexString:@"BFE5FA" alpha:0.5];
    
    line.backgroundLineColor = [self colorWithHexString:@"#4b4e52" alpha:1];
    
    [self.view addSubview:line];//折线图
}

- (void)circle_init{//扇形初始化
    int X = 0;//实际消费占本月预算的百分比
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat chartWidth = self.view.frame.size.width * 0.7;
    CGFloat x = (width - chartWidth) / 2;
    CGFloat y = (height - chartWidth) / 3;
    
    X = ([self->Actual_content.text floatValue] / [self->Budget_content.text floatValue]) * 100;
    
    circle = [[HXCircleChart alloc] initWithFrame:CGRectMake(x, y, chartWidth, chartWidth) withMaxValue:100 value:X];
    NSLog(@"百分比为：%d,实际消费：%d，本月预算：%d",X,[self->Actual_content.text intValue],[self->Budget_content.text intValue]);
    circle.valueTitle = [NSString stringWithFormat:@"%d%@",X,@"%"];
    circle.valueColor = [UIColor blackColor];
    circle.colorArray = @[[self colorWithHexString:@"#FEEB90" alpha:1],[self colorWithHexString:@"#F6A945" alpha:1]];
    circle.locations = @[@0.15,@0.85];
    [self.view addSubview:circle];
}

- (void)changeValue:(NSNotification *)notification{
    id value = notification.object;
    self->Budget_content.text = value;
}

- (void)value:(UISegmentedControl *)segmented{
    
    if (segmented.selectedSegmentIndex == 0){
        [self line_init];
        [circle setHidden:YES];
    }
    
    else if (segmented.selectedSegmentIndex == 1){
        [self circle_init];
        [line setHidden:YES];
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
@end
