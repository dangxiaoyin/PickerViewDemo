//
//  ViewController.m
//  PickerView练习
//
//  Created by Mac on 15-3-26.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *_leftArray;
    NSMutableArray *_middleArray;
    NSMutableArray *_rightArray;

    
    NSMutableArray *_henanArray;
    NSMutableArray *_hebeiArray;
    NSMutableArray *_shandongArray;
    
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
//    创建pickerView对象 指定位置大小
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, 320, 300)];
    
//    pickerView.backgroundColor = [UIColor grayColor];

//    数据源、代理
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [self.view addSubview:pickerView];
    
    
//   1. 创建可变数组  来存放第一个区的内容
    _leftArray = [[NSMutableArray alloc] initWithObjects:@"河南",@"河北",@"山东", nil];
    
//   2. 创建3个不可变数组  来存放第二个区的内容
    NSArray *heNanArray = @[@"郑州",@"洛阳",@"南阳"];
    NSArray *heBeiArray = @[@"石家庄",@"唐山",@"衡水"];
    NSArray *shanDongArray = @[@"青岛",@"济南",@"烟台"];
    
//    创建大数组  来存放第二个区的3个小数组
    _middleArray = [[NSMutableArray alloc] initWithObjects:heNanArray,heBeiArray,shanDongArray, nil];

    
//   3. 创建数组  来存放第三个区的内容
    
    NSArray *zzArray = @[@"郑州A区",@"郑州B区",@"郑州C区"];
    NSArray *lyArray = @[@"洛阳A区",@"洛阳B区",@"洛阳C区"];
    NSArray *nyArray = @[@"南阳A区",@"南阳B区",@"南阳C区"];
    _henanArray = [[NSMutableArray alloc] initWithObjects:zzArray,lyArray,nyArray, nil];
    
    
    NSArray *sjzArray = @[@"石家A区",@"石家B区",@"石家C区"];
    NSArray *tsArray = @[@"唐山A区",@"唐山B区",@"唐山C区"];
    NSArray *hsArray = @[@"衡水A区",@"衡水B区",@"衡水C区"];
    _hebeiArray = [[NSMutableArray alloc] initWithObjects:sjzArray,tsArray,hsArray, nil];

    
    
    NSArray *qdArray = @[@"青岛A区",@"青岛B区",@"青岛C区"];
    NSArray *jnArray = @[@"济南A区",@"济南B区",@"济南C区"];
    NSArray *ytArray = @[@"烟台A区",@"烟台B区",@"烟台C区"];
    _shandongArray = [[NSMutableArray alloc] initWithObjects:qdArray,jnArray,ytArray, nil];

    
    
    
    
    
//    创建大数组  来存放以上 3组 小数组
    _rightArray = [[NSMutableArray alloc] initWithObjects:_henanArray,_hebeiArray,_shandongArray, nil];
    
    
    
    
}


#pragma mark -
#pragma mark -必须实现的方法-

//  设置多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


//  设置每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    返回第几区的行数
    if (component == 0)
    {
        return _leftArray.count;
    }
    
    else if (component == 1)
    {
//       获取选中区中的行 数值
        int currentRow = [pickerView selectedRowInComponent:0];
//       获取与当前行索引值相对应的小数组
        NSArray *smallArray = [_middleArray objectAtIndex:currentRow];
//       返回获取到的数组的.count值
        return smallArray.count;
    }
    
    else
    {
        int currentRow = [pickerView selectedRowInComponent:1];
        NSArray *smallArray = [_rightArray objectAtIndex:currentRow];
        
        return smallArray.count;

    }
    
//    return 0;
}


#pragma mark -
#pragma mark -其他方法-

//设置区中的每一行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return  [_leftArray objectAtIndex:row];
    }
    
    else if(component == 1)
    {
        
        int currentRow = [pickerView selectedRowInComponent:0];
        
        NSArray *smallArray = [_middleArray objectAtIndex:currentRow];
        
        NSString *title = [smallArray objectAtIndex:row];
        
        return title;
    }
    
    
    else
    {
//        通过判断第0区的行数值，来确定第2区选择哪一个小数组
        int aRow = [pickerView selectedRowInComponent:0];
        if (aRow == 0)
        {
//            获取当前选中的区的行数值
            int currentRow = [pickerView selectedRowInComponent:1];
//            获取与当前行数值相对应的小数组
            NSArray *smallArray = [_henanArray objectAtIndex:currentRow];
//            获取  获取到的小数组中的标题
            NSString *title = [smallArray objectAtIndex:row];
            return title;
        }

        if (aRow == 1)
        {
            int currentRow = [pickerView selectedRowInComponent:1];
            NSArray *smallArray = [_hebeiArray objectAtIndex:currentRow];
            NSString *title = [smallArray objectAtIndex:row];
            return title;
        }
        
        if (aRow == 2)
        {
            int currentRow = [pickerView selectedRowInComponent:1];
            NSArray *smallArray = [_shandongArray objectAtIndex:currentRow];
            NSString *title = [smallArray objectAtIndex:row];
            return title;
        }
        
    }
    return nil;
}



//已经选择了某个区地某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
//        刷新所有区
        [pickerView reloadAllComponents];
//        指定刷新某一个区
        [pickerView reloadComponent:1];
//       指定选择某一个区的某一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    

    else if(component == 1)
    {
        
//        刷新所有区
        [pickerView reloadAllComponents];
        
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
 
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
