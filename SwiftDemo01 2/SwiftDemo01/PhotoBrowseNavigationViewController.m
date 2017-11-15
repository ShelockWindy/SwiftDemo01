//
//  PhotoBrowseNavigationViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/9.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "PhotoBrowseNavigationViewController.h"
#import <Photos/Photos.h>


@interface PhotoBrowseNavigationViewController ()

@property (nonatomic,strong) UINavigationBar * myNavigationBar;
@property (nonatomic,strong) UINavigationItem * myNavigationItem;

@end

@implementation PhotoBrowseNavigationViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        
        PhotoBrowseViewController * photoVC = [[PhotoBrowseViewController alloc]init];

        self = [[PhotoBrowseNavigationViewController alloc]initWithRootViewController:photoVC];
        
        self.navigationBarHidden = YES;
        
        self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-64);
        
        _myNavigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        
        
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(leftItemAction:)];
        
        
        _myNavigationItem = [[UINavigationItem alloc]init];
        _myNavigationItem.title = @"xhhshdhas";
        _myNavigationItem.leftBarButtonItem = leftItem;
        
        [self.view addSubview:_myNavigationBar];
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [_myNavigationBar pushNavigationItem:_myNavigationItem animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma- Private Method

-(void)leftItemAction:(UIBarButtonItem*)sender
{
    
    if (self.presentationController) {
        [self dismissViewControllerAnimated:YES completion:nil];

    }else
    {
        [self popViewControllerAnimated:YES];
    }
    

    
}

@end


@interface PhotoBrowseCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * photoView;//图片
@property (nonatomic,strong) UIImageView * checkView;//标记
@property (nonatomic,assign) BOOL  checked;//选中状态

@end


@implementation PhotoBrowseCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
    
    if (self) {
        
        _photoView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_photoView];
        
        _checkView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-25, 20, 20, 20)];
        [self addSubview:_checkView];
        
    }
    
    return self;
}

@end


@interface PhotoBrowseViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
}

@property (nonatomic,strong) UICollectionView * collectionView;

@end


@implementation PhotoBrowseViewController

#pragma mark- Life Cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    CGFloat itemWidth = (self.view.frame.size.width - 5*3)/4;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    _collectionView  = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[PhotoBrowseCollectionCell class] forCellWithReuseIdentifier:@"cellId_browsePhoto"];
    
    [self.view addSubview:_collectionView];
}


#pragma mark- System Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   static  NSString * cellIdentifier = @"cellId_browsePhoto";
    
    PhotoBrowseCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.photoView.image = [UIImage imageNamed:@"33.png"];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}




@end









