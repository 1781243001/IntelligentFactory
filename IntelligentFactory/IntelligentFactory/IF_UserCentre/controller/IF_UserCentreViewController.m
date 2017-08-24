//
//  IF_UserCentreViewController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/7/18.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "IF_UserCentreViewController.h"
#import "FunctionButton.h"
#import "UserMessageView.h"
#import "UserListTableViewCell.h"
#import "SnailAlertView.h"
#import "SnailPopupController.h"
#import "UserAlertView.h"
@interface IF_UserCentreViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UserMessageView *useMessageView;
@property (nonatomic,strong) NSArray *defaultArr;
@property (nonatomic,strong) UserAlertView *userAlertView;
@end

@implementation IF_UserCentreViewController

-(NSArray *)defaultArr{
    
    if (!_defaultArr) {
        _defaultArr = @[@{@"section":@[
                                  @{@"title":@"UID",@"image":@"user_UID"},
                                  @{@"title":@"企业",@"image":@"user_unit"},
                                  @{@"title":@"部门",@"image":@"user_department"},
                                  @{@"title":@"职位",@"image":@"user_position"}
                                  ]},
                        @{@"section":@[
                                  @{@"title":@"手机",@"image":@"user_iphone"},
                                  @{@"title":@"座机",@"image":@"user_telephone"},
                                  @{@"title":@"邮箱",@"image":@"user_mail"},
                                  ]}];
        
    }
    return _defaultArr;
}
-(UITableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_useMessageView.frame), kScreen_Width, kScreen_Height -64 - 164) style:(UITableViewStyleGrouped)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.showsVerticalScrollIndicator = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,50)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *outloginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,  kScreen_Width, CGRectGetHeight(view.frame)-10)];
        outloginLabel.textAlignment = NSTextAlignmentCenter;
        outloginLabel.textColor = [UIColor blackColor];
        outloginLabel.backgroundColor = [UIColor whiteColor];
        outloginLabel.font = [UIFont systemFontOfSize:18];
        outloginLabel.text = @"退出登录";
        [view addSubview:outloginLabel];
        outloginLabel.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.3].CGColor;
        outloginLabel.layer.borderWidth = 1.0f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(walkoutLogin)];
        [view addGestureRecognizer:tap];
        _listTableView.tableFooterView = view;
        
//        _listTableView.contentInset = UIEdgeInsetsMake(164, 0, 0, 0);
    }
    return _listTableView;
}

-(UserMessageView *)useMessageView{
    if (!_useMessageView) {
        WEAKSELF;
        _useMessageView = [[UserMessageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 164) block:^{
            [weakSelf customTime];
        }];
    }
    return _useMessageView;
}

-(void)customTime{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel = UIWindowLevelAlert;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, -20, kScreen_Width, 20)];
    label.text = @"请使用本人照片作为头像!";
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor hexString:@"F08200"];
    label.textColor = [UIColor whiteColor];
    [window addSubview:label];
    
    [UIView animateWithDuration:0.1 animations:^{
        label.frame = CGRectMake(0, 0, kScreen_Width, 20);
    }];
    WEAKSELF;
    UIAlertController *alert;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                label.frame = CGRectMake(0, -20, kScreen_Width, 20);
            } completion:^(BOOL finished) {
                window.windowLevel = UIWindowLevelNormal;
                [label removeFromSuperview];
            }];
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"从相册选一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [UIView animateWithDuration:0.10 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                label.frame = CGRectMake(0, -20, kScreen_Width, 20);
            } completion:^(BOOL finished) {
                window.windowLevel = UIWindowLevelNormal;
                [label removeFromSuperview];
            }];

            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                picker.delegate = weakSelf;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [weakSelf presentViewController:picker animated:YES completion:^{
                }];
            }
        }];
        UIAlertAction *sure1 = [UIAlertAction actionWithTitle:@"拍一张照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                label.frame = CGRectMake(0, -20, kScreen_Width, 20);
            } completion:^(BOOL finished) {
                window.windowLevel = UIWindowLevelNormal;
                [label removeFromSuperview];
            }];
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                picker.delegate = weakSelf;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [weakSelf presentViewController:picker animated:YES completion:^{
                }];
            }
        }];
        [alert addAction:cancel];
        [alert addAction:sure];
        [alert addAction:sure1];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
}
-(void)clickBlockTag:(ClickIncidentType )tag{
    
    switch (tag) {
        case ClickIncidentDetele:
            [self.sl_popupController dismiss:YES];
            break;
        case ClickIncidentPhoto:
            [self.sl_popupController dismiss:NO];
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:^{
                }];
            }
            break;
        case ClickIncidentTakephoto:
            [self.sl_popupController dismiss:NO];
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:^{
                }];
            }
            break;
        case ClickIncidentTelephoneButton:
        {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            [MBProgressHUD showHUDAddedTo:window animated:YES];
           UITextField *textfield = [_userAlertView viewWithTag:ClickIncidentTelephoneTextFiled];
            DHLog(@"%@",textfield.text);

        }
            break;
  
        default:
            break;
    }
    
}
#pragma mark  获取照片的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage * imagePicker = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImageView *imageView = [self.view viewWithTag:10000];
     NSData *imageData = UIImagePNGRepresentation(imagePicker);
    [[NSUserDefaults standardUserDefaults] setValue:imageData forKey:@"HeaderPhoto"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:imagePicker];
//    [self getImageFromPicker:imagePicker];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationDeploy];
    [self createUserView];
}

-(void)setNavigationDeploy{
    UIImageView * lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    lineView.hidden = YES;
    self.navigationItem.title = @"个人中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    WEAKSELF;
//    FunctionButton *btn = [[FunctionButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30) withType:(UIButtonTypeCustom) image:@"user_back" block:^(UIButton *sender) {
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItems = @[item];
}

-(void)createUserView{
    [self.view addSubview:self.useMessageView];
    [self.view addSubview:self.listTableView];
}

//找到导航栏最下面黑线视图
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height > _listTableView.bounds.size.height) {
        _listTableView.scrollEnabled = YES;
        if (_listTableView.contentOffset.y <= 0) {
            _listTableView.bounces = NO;
        }
        else
            if (_listTableView.contentOffset.y >= 0){
                _listTableView.bounces = YES;
            }
    }else{
        _listTableView.scrollEnabled = NO;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [self.defaultArr objectAtIndex:section];
    NSArray *array = [dic objectForKey:@"section"];
    return [array count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 20;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"userListcell";
    UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UserListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    if (indexPath.section == 2) {
        [cell outlogin];
    }else{
        NSDictionary *dic = [_defaultArr objectAtIndex:indexPath.section];
        NSDictionary *titleDic = [[dic objectForKey:@"section"] objectAtIndex:indexPath.row];
        NSArray *arr = nil;
        if (indexPath.section == 0) {
            arr = @[@"zs123456",@"青岛炼化",@"炼油事业部",@"车间主任"];

        }else{
             arr = @[@"13312345678",@"010-12345678",@"12345@1234.com"];

        }
        [cell setUserMessageDataDic:titleDic title:arr[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
//        AlertType type = 0;
//        switch (indexPath.row) {
//            case 0:
//                type = UserChangePhone;
//                break;
//            case 1:
//                type =UserChangeTelephone;
//                break;
//            case 2:
//                type = UserChangeMail;
//                break;
//            default:
//                break;
//        }
//        WEAKSELF;
//        UserAlertView *userAlert = [[UserAlertView alloc]initAlertype:type width:290 block:^(ClickIncidentType tag) {
//            
//            [weakSelf clickBlockTag:tag];
//            
//        }];
//        _userAlertView = userAlert;
//        self.sl_popupController = [SnailPopupController new];
//        self.sl_popupController.maskType = PopupMaskTypeDefault;
//        self.sl_popupController.transitStyle = PopupTransitStyleShrinkInOut;
//        [self.sl_popupController presentContentView:userAlert duration:0.5 elasticAnimated:YES];
    }else if (indexPath.section == 2){
        [self walkoutLogin];
    }
    
}
#pragma  mark  退出app
-(void)walkoutLogin{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"是否注销账户" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        AppDelegate *app =[AppDelegate sharedApplication];
        app.loginCon.homeListCon = nil;
        app.window.rootViewController = app.loginCon;
    }];
    [ac addAction:cancel];
    [ac addAction:sure];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
