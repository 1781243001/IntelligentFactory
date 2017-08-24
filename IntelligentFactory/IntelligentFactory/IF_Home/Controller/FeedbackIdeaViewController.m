//
//  FeedbackIdeaViewController.m
//  IntelligentFactory
//
//  Created by My Book on 2017/8/9.
//  Copyright © 2017年 Iphone. All rights reserved.
//

#import "FeedbackIdeaViewController.h"
#import "ProblemAndIdeaTableViewCell.h"
#import "CutPhotoCell.h"
#import "CutoffPhotoTableViewCell.h"
@interface FeedbackIdeaViewController ()<UITableViewDelegate,UITableViewDataSource,ProblemAndIdeaTableViewCellDelegate,CutoffPhotoTableViewCellDetagate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    NSInteger _row;;
    NSString *_feedbackString;
    NSString *_phoneSting;
    NSString *_nameString;
}
@property (nonatomic,strong)UITableView *listTableView;
@property (nonatomic,strong) NSMutableArray *photoArray;
@end

@implementation FeedbackIdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbHideShow:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.title = @"意见反馈";
    [self.view addSubview:self.listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    // Do any additional setup after loading the view.
}
- (void)kbWillShow:(NSNotification *)notidication {
    _listTableView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64);
    if (_row != 0) {
        NSDictionary *userInfo = [notidication userInfo];
        NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        int height = keyboardRect.size.height;
        _listTableView.frame = CGRectMake(0, 0, kScreen_Width, _listTableView.frame.size.height - height);
        
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:_row];
        
        [_listTableView scrollToRowAtIndexPath:scrollIndexPath
                              atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }else{
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:_row];
        
        [_listTableView scrollToRowAtIndexPath:scrollIndexPath
                              atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void)kbHideShow:(NSNotification *)notidication{
    [self.view endEditing:YES];
    _listTableView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64);

    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_listTableView scrollToRowAtIndexPath:scrollIndexPath
                          atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)whetherScrollView:(NSInteger)section{
    _row = section;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"feedbackcell";
    switch (indexPath.section) {
        case 0:
        {
            ProblemAndIdeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[ProblemAndIdeaTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
            [cell textViewConfigurationPlaceholder:@"请填写十个字以上的问题描述以便我们更好的改善软件的体验!" frame:(CGRect){0,0,kScreen_Width,120} maxlength:200];
            cell.textView.tag = 0;
            cell.delegate = self;
            [cell.textView didChangeText:^(PlaceholderTextView *textView) {
                _feedbackString = textView.text;
            }];
            return cell;
        }
            break;
        case 1:{
            CutoffPhotoTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[CutoffPhotoTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
            [cell setData:self.photoArray];
            cell.delegate = self;
            return cell;
        }
            break;
        case 2:{
            ProblemAndIdeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[ProblemAndIdeaTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
            cell.delegate = self;
            [cell textViewConfigurationPlaceholder:@"选填，便于我们联系您!" frame:(CGRect){0,0,kScreen_Width,40} maxlength:0];
//            cell.textView.keyboardType = UIKeyboardTypeNamePhonePad;
            cell.textView.tag = 2;
            [cell.textView didChangeText:^(PlaceholderTextView *textView) {
                _phoneSting = textView.text;
            }];
            return cell;
        }
            break;
        case 3:{
            ProblemAndIdeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[ProblemAndIdeaTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
            cell.delegate = self;
            [cell textViewConfigurationPlaceholder:@"选填，便于我们联系您!" frame:(CGRect){0,0,kScreen_Width,40} maxlength:0];
            cell.textView.tag = 3;
            [cell.textView didChangeText:^(PlaceholderTextView *textView) {
                _nameString = textView.text;
            }];
            return cell;
        }
            break;
        
    }
    return nil;
}

-(void)pushPhoto{
    WEAKSELF;
    UIAlertController *alert;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"从相册选一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                picker.delegate = weakSelf;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [weakSelf presentViewController:picker animated:YES completion:^{
                }];
            }
        }];
        UIAlertAction *sure1 = [UIAlertAction actionWithTitle:@"拍一张照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                picker.delegate = weakSelf;
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage * imagePicker = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSData *dataz = UIImageJPEGRepresentation(imagePicker, 1.0);

    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:imagePicker, nil];
    [array addObjectsFromArray:_photoArray];
    _photoArray = array;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_listTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 120;
            break;
        case 1:
            return 65;
            break;
        case 2:
        case 3:
            return 40;
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Height, 35)];
    view.backgroundColor = [UIColor hexString:@"f5f5f5"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 7.5, kScreen_Width, 20)];
    NSArray *arr = @[@"问题和意见",@"图片 (选填，提供问题页面截图)",@"联系电话",@"姓名"];
    label.textColor = [UIColor hexString:@"333333"];
    label.text = [arr objectAtIndex:section];
    label.font = [UIFont systemFontOfSize:14.f];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.1;
}


-(UITableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.scrollEnabled = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
        
        UIButton *sureButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        sureButton.frame = CGRectMake(0, 30, kScreen_Width, 50);
        [sureButton addTarget:self action:@selector(sureBtn) forControlEvents:(UIControlEventTouchUpInside)];
        sureButton.backgroundColor = [UIColor whiteColor];
        [sureButton setTitle:@"提交" forState:(UIControlStateNormal)];
        [sureButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        sureButton.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.3].CGColor;
        sureButton.layer.borderWidth = 1.0f;
        [view addSubview:sureButton];
        _listTableView.tableFooterView = view;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kbHideShow:)];
        [_listTableView addGestureRecognizer:tapGestureRecognizer];
    }
    return _listTableView;
}
#pragma mark -上传意见
-(void)sureBtn{
    if (_feedbackString.length < 10) {
        [PromptMessage show:@"问题与意见不到十个字"];
        return;
    }
    if (!_phoneSting.length) {
        _phoneSting = @"";
    }
    if (!_feedbackString.length) {
        _feedbackString = @"";
    }
    if (!_nameString.length) {
        _nameString = @"";
    }
    NSDictionary *dic = @{@"feekbeck":_feedbackString,@"phone":_phoneSting,@"name":_nameString};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestService AFN_UploadJSONResponseUrlType:RequestFeedbackidea param:dic dataArray:_photoArray modelClass:nil responseBlock:^(id dataObj, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [PromptMessage show:@"上传失败"];
        }
        [PromptMessage show:@"上传成功"];
        [self.navigationController popViewControllerAnimated:YES];

    }];
    
    
}

-(void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)photoArray{
    
    if (!_photoArray) {
        _photoArray = [NSMutableArray arrayWithObject:@"addPhoto.png"];
    }
    return _photoArray;
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
