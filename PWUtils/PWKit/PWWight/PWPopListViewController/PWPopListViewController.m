//
//  PWPopListViewController.m
//  BaseUIKit
//
//  Created by 王宁 on 2018/7/25.
//

#import "PWPopListViewController.h"
#import <WEPopover/WEPopoverController.h>


@implementation PWPopListViewConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:14];
        _rowHeight = 44;
        _rowWidth = 50;
        _maxTableViewHeight = -1;
        _textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)dealloc{
    _titles = nil;
    _font = nil;
}

@end


@interface PWPopListViewController (){
    WEPopoverController *pp;
}

@property (nonatomic , weak)IBOutlet UITableView *tableView;
@property (nonatomic , strong)WEPopoverController *pp;
@end

@implementation PWPopListViewController
@synthesize pp;

+ (void)showViewControllerWith:(PWPopListViewConfig *)config on:(id)sender block:(PWPopListViewEvent)event{
    PWPopListViewController *popListViewController = [[PWPopListViewController alloc] initWithConfig:config];
    popListViewController.clickEvent = event;
    [popListViewController makePPAndShowFrom:sender];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _config = [[PWPopListViewConfig alloc] init];
    }
    return self;
}

- (id)initWithConfig:(PWPopListViewConfig *)config{
    self = [super init];
    if (self) {
        _config = config;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    _config = nil;
    [pp dismissPopoverAnimated:NO];
    pp = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)makePPAndShowFrom:(id)sender{
    if (!pp) {
        self.preferredContentSize = [self getRect].size;//设置浮窗的宽高
        self.modalPresentationStyle = UIModalPresentationPopover;
        pp = [[WEPopoverController alloc]initWithContentViewController:self];
        pp.parentView = [UIApplication sharedApplication].keyWindow;
        pp.popoverContentSize = self.view.frame.size;
    }
    CGRect bounds = [sender bounds];
    bounds.origin.y = bounds.origin.y + 20;
    bounds.size.height = bounds.size.height - 40;
    pp.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
    [pp presentPopoverFromRect:bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown animated:YES];
}

- (void)setConfig:(PWPopListViewConfig *)config{
    _config = config;
    [self.tableView reloadData];
}

- (CGRect)getRect{
    CGRect rect = CGRectMake(0, 0, 50, 100);
    if (_config) {
        rect.size.width = _config.rowWidth;
        rect.size.height = _config.rowHeight * _config.titles.count;
        rect.size.height = rect.size.height > _config.maxTableViewHeight && _config.maxTableViewHeight > 0 ? _config.maxTableViewHeight : rect.size.height;
        self.view.frame = rect;
    }
    return rect;
}

- (void)setTableView:(UITableView *)tableView{
    _tableView = tableView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_config) {
        return _config.titles.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_config) {
        return _config.rowHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"PWPopListViewController_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UILabel *label = [cell viewWithTag:10];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _config.rowWidth, _config.rowHeight)];
        label.tag = 10;
        label.font = _config.font;
        label.textAlignment = _config.textAlignment;
        [cell addSubview:label];
    }
    label.text = _config.titles[indexPath.row];
    
    
    UIView *lineView = [cell viewWithTag:201];
    if (indexPath.row!=_config.titles.count-1) {
        if (!lineView) {
            lineView = [[UIView alloc] initWithFrame:CGRectZero];
        }
        lineView.frame = CGRectMake(0, _config.rowHeight-.5, self.tableView.frame.size.width, .5);
        lineView.tag = 201;
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineView];
    }else{
        if (lineView) {
            [lineView removeFromSuperview];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_clickEvent) {
        self.clickEvent(self, indexPath.row, _config.titles.count > indexPath.row ? _config.titles[indexPath.row] : @"");
    }
    if (pp) {
        __weak typeof(self) weakSelf = self;
        [pp dismissPopoverAnimated:YES completion:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.pp.contentViewController = nil;
            strongSelf.pp = nil;
        }];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    // This will create a "invisible" footer
    return 0.01f;
}

@end
