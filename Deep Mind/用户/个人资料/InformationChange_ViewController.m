//
//  InformationChange_ViewController.m
//  Hi,I'm Wait
//
//  Created by 妳的小可愛已上線 on 2019/9/24.
//  Copyright © 2019 妳的小可愛已上線. All rights reserved.
//

#import "InformationChange_ViewController.h"
#import "User_ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface InformationChange_ViewController ()
#define  fresh  true
@end

@implementation InformationChange_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"信息";
    
    UINavigationBar *bar = self.navigationController.navigationBar;//导航栏背景色
    bar.barTintColor = [self colorWithHexString:@"F2C200" alpha:1.0f];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage   imageNamed:@"back.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector((back_click))];//返回按钮
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    TableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStyleGrouped)];
    TableView.backgroundColor = [UIColor whiteColor];
    [TableView setDataSource:self];
    [TableView setDelegate:self];
    TableView.sectionHeaderHeight = 10.0f;//设置每个cell的上间距
    TableView.sectionFooterHeight = 10.0f;//设置每个cell的下间距
    TableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);//设置第一组cell的导航栏的距离
    TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//设置cell之间的分割线为无
    self.view = TableView;

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults valueForKey:@"value"];
    if (value!=NULL){
        //Name.text = value;
    }
}


- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
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

//返回cell的section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//返回cell的row的个数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    user_photo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i.png"]];
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
                        Cell.textLabel.text = @"头像";
                        Cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                       Cell.accessoryView = user_photo;
                        break;
                        
                     case 1:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"昵称";
                        if (_state == true) {
                            Cell.detailTextLabel.text = _username;//用户名传值
                        }else{
                            Cell.detailTextLabel.text = @"亦灿";
                        }
                        
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                     case 2:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"性别";
                        Cell.detailTextLabel.text = @"女";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                      case 3:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"年龄";
                        Cell.detailTextLabel.text = @"25";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                       case 4:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"职业";
                        Cell.detailTextLabel.text = @"学生";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                       case 5:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:15];
                        Cell.textLabel.text = @"月收入";
                        Cell.detailTextLabel.text = @"2000";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;
                       case 6:
                        Cell.textLabel.font = [UIFont fontWithName:@"Marion" size:20];
                        Cell.textLabel.text = @"tel";
                        Cell.detailTextLabel.text = @"13527359420";
                        Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        break;

                    default:
                        break;
                }

            default:
                break;
        }
    }
    return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{     //cell的点击响应事件
    UIAlertController *change_name = [UIAlertController alertControllerWithTitle:@"请输入昵称：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_name.view.backgroundColor = [UIColor whiteColor];
    change_name.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_age = [UIAlertController alertControllerWithTitle:@"请输入年龄：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_age.view.backgroundColor = [UIColor whiteColor];
    change_age.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_profession = [UIAlertController alertControllerWithTitle:@"请输入职业：" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    //change_profession.view.backgroundColor = [UIColor whiteColor];
    change_profession.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_monthly_income = [UIAlertController alertControllerWithTitle:@"请输入月收入：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_monthly_income.view.backgroundColor = [UIColor whiteColor];
    change_monthly_income.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_tel = [UIAlertController alertControllerWithTitle:@"请输入tel：" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    //change_tel.view.backgroundColor = [UIColor whiteColor];
    change_tel.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertController *change_sex = [UIAlertController alertControllerWithTitle:@"请选择性别：" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    //change_sex.view.backgroundColor = [UIColor whiteColor];
    change_sex.view.tintColor = [UIColor systemBlueColor];
    
    UIAlertAction *man = [UIAlertAction actionWithTitle:@"男" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"男";
    }];
    UIAlertAction *woman = [UIAlertAction actionWithTitle:@"女" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"女";
    }];
    UIAlertAction *secret = [UIAlertAction actionWithTitle:@"保密" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"保密";
    }];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSArray *let;
        switch (indexPath.row) {
            case 1:
                let = change_name.textFields;
                break;
            case 3:
                let = change_age.textFields;
                break;
            case 5:
                let = change_monthly_income.textFields;
                break;
            case 6:
                let = change_tel.textFields;
                break;
            default:
                break;
        }
        
        UITextField *field = let[0];
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text =
        field.text;
    }];
    UIAlertAction *student = [UIAlertAction actionWithTitle:@"学生" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"学生";
    }];
    UIAlertAction *civil_servant = [UIAlertAction actionWithTitle:@"公务员" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"公务员";
    }];
    UIAlertAction *sole_trader = [UIAlertAction actionWithTitle:@"个体自营" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"个体自营";
    }];
    UIAlertAction *other_profession = [UIAlertAction actionWithTitle:@"其他职业" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text = @"其他职业";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:(@"取消") style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    switch (indexPath.row) {
        case 0:{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            //通过图库来采集
            else{
                self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            //弹出pickerViewController
            [self presentViewController:_pickerController animated:YES completion:nil];
            user_photo.layer.cornerRadius = user_photo.frame.size.height/4;//设置用户头像为圆形
            [tableView cellForRowAtIndexPath:indexPath].accessoryView = user_photo;
        }
            break;
        case 1:
            [change_name addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"输入");
            }];
            [change_name addAction:save];
            [change_name addAction:cancel];
            [self presentViewController:change_name animated:YES completion:nil];
            break;
        case 2:
            [change_sex addAction:man];
            [change_sex addAction:woman];
            [change_sex addAction:secret];
            [change_sex addAction:cancel];
            [self presentViewController:change_sex animated:YES completion:nil];
            break;
        case 3:
            [change_age addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"输入");
            }];
            [change_age addAction:save];
            [change_age addAction:cancel];
            [self presentViewController:change_age animated:YES completion:nil];
            break;
        case 4:
            [change_profession addAction:civil_servant];
            [change_profession addAction:student];
            [change_profession addAction:sole_trader];
            [change_profession addAction:other_profession];
            [change_profession addAction:cancel];
            [self presentViewController:change_profession animated:YES completion:nil];
            break;
        case 5:
            [change_monthly_income addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"输入");
            }];
            [change_monthly_income addAction:save];
            [change_monthly_income addAction:cancel];
            [self presentViewController:change_monthly_income animated:YES completion:nil];
            break;
        case 6:
            [change_tel addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"输入");
            }];
            [change_tel addAction:save];
            [change_tel addAction:cancel];
            [self presentViewController:change_tel animated:YES completion:nil];
            break;
        case 7:
            
            break;
        default:
            break;
    }
    
}

//设置某一个row对应的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    }else
        return 50;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{

}


- (void)changeValue:(NSNotification *)notification{
    id value = notification.object;
    //Name.text = value;
}

-(UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc]init];
        
        //1.设置数据源类型
        _pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //2.设置媒体类型(总共两种类型：图片或视频)
        //_bridge将C语言类型的kUTTypeImage(图片类型)桥接为NSString类型
        _pickerController.mediaTypes = [NSArray arrayWithObject:(
                                                                 __bridge NSString*)kUTTypeImage];
        
        //3.设置代理
        _pickerController.delegate = self;
    }
    return _pickerController;
}


//完成采集图片后的处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    //从info里获取媒体类型
    NSString *type = info[UIImagePickerControllerMediaType];
    //如果媒体类型是图片类型
    if ([type isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        //从info里获取采集图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        //显示到UI界面
        user_photo.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消采集图片后的处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancle");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(nonnull UIImage *)image editingInfo:(nullable NSDictionary<UIImagePickerControllerInfoKey,id> *)editingInfo{
    [picker dismissModalViewControllerAnimated:YES];
    [self performSelector:@selector(editImage:) withObject:image afterDelay:1.0];
}

- (void)back_click{//需要修改
//    User_ViewController *user_fresh = [[User_ViewController alloc]init];
//    user_fresh.hidesBottomBarWhenPushed = NO;
//    [self.navigationController pushViewController:user_fresh animated:YES];
//    user_fresh.tel = Cell.detailTextLabel.text;
//    user_fresh.username = Cell.detailTextLabel.text;
//    user_fresh.fresh_state = fresh;
//    [user_fresh.navigationItem setHidesBackButton:YES];
    [self.navigationController popViewControllerAnimated:self];
}


@end
