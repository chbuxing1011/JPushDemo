# ALLibrary-ios 

站在巨人的肩膀上，针对`RTALLibrary-ios`进行了扩展和修改，主要是针对自己使用的项目做一些优化。后续会慢慢添加需要的东西

## 更新日志
`2014.10.29更新`

添加了`RTSoapClient`，支持通过`AFNetWorking`发送`Soap`请求。修改请求体的字符串拼接
```objective-c
/**
*  根据参数生成请求体
*
*  @param param  请求参数
*  @param method 请求方法
*
*  @return 添加请求体
*/
- (NSString *)requestBody:(NSDictionary *)param method:(NSString *)method {
NSMutableString *soapReq = [[NSMutableString alloc] init];
[soapReq appendString:
@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope "];
[soapReq
appendString:@"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "];
[soapReq appendString:@"xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "];
[soapReq appendString:
@"xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" "];
[soapReq appendFormat:@"xmlns=\"%@\"><soap:Body>", kSOAP_XMLNS_NAME];
[soapReq appendFormat:@"<%@ xmlns=\"%@\">", method, kSOAP_XMLNS_NAME];
NSArray *allkeys = [param allKeys];
for (NSString *key in allkeys) {
[soapReq appendFormat:@"<%@>%@</%@>", key, [param objectForKey:key], key];
}
[soapReq appendFormat:@"</%@>", method];
[soapReq appendString:@"</soap:Body></soap:Envelope>"];

return soapReq;
}
```
调用示例：
```objective-c 
- (IBAction)queryProduct:(id)sender {
NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
[param setObject:[NSNumber numberWithInt:3]
forKey:kSOAP_PARAM_GETPROMOTIONSBYTIMESTAMP_COUNT];

[[RTSoapClient manager] requestWithPath:kSOAP_URL_PRODUCT
method:KSOAP_METHOD_GETPROMOTIONSBYTIMESTAMP
parameters:param
success: ^(AFHTTPRequestOperation *operation, id responseObject) {
NSLog(@"responseObject:\n%@", responseObject);
}

failure: ^(AFHTTPRequestOperation *operation, NSError *error) {}];
}
```



`2014.10.16更新`

由于下午要出外地，所以今天上午初步集成了`AEFDataSource`,这个框架是把`UITableView`的数据源封装起来，让我们可以很方便的使用表格，调用方式如下：

首先，导入用到的头文件并且添加一个数据源对象
```objective-c
// DataSource
#import "AEFTableViewDataSource.h"
#import "AEFTableCollection.h"

@property (nonatomic, strong) AEFTableViewDataSource *dataSource;
```
然后在代码里使用以下方法进行调用：
```objective-c
//注册cell
[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

AEFTableCollection *collection = [[AEFTableCollection alloc] initWithObjects:@[@"Row", @"Row", @"Row"]
cellIdentifier:@"Cell"];

self.dataSource = [[AEFTableViewDataSource alloc] initWithCollection:collection configureCellBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
cell.textLabel.text = [NSString stringWithFormat:@"%@_%i", item, indexPath.row];
}];

self.tableView.dataSource = self.dataSource;
```
如果想在表格中使用多个`Section`，参考如下代码：
```objective-c
[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

AEFTableSectionCollection *collection = [[AEFTableSectionCollection alloc] initWithObjects:@[@"Row", @"Row"] cellIdentifier:@"Cell"];
[collection addObjects:@[@"Row", @"Row", @"Row"] toSection:1 withCellIdentifier:@"Cell"];
[collection addObjects:@[@"Row", @"Row", @"Row"] toSection:2 withCellIdentifier:@"Cell"];
[collection addObjects:@[@"Row", @"Removed", @"Row"] toSection:3 withCellIdentifier:@"Cell"];
[collection removeObjects:@[@"Removed"] fromSection:3];

self.dataSource = [[AEFTableViewDataSource alloc] initWithCollection:collection configureCellBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
cell.textLabel.text = [NSString stringWithFormat:@"%@_%i", item, indexPath.row];
}];

self.tableView.dataSource = self.dataSource;
```
目前还缺少对`Section`一些数据源的封装，后面如果有需要，会在写个类继承一下。等我从外地回来后，会把下拉刷新和`loadMore`也给合进去，这样以后使用表格就比较方便了

`2014.10.15更新`

目前正在集成`NanoStore`,这是一个数据持久化框架，提供的很方便的数据存储，现在还在集成中，今天添加的功能是本地测试桩，在开发过程中，难免会遇到接口延迟的情况，项目开发又不能一直等待接口，所以萌生了这个想法，目前的处理方法是在本地建立一个`LocalServer`文件夹，把模拟的接口数据放到对应的文件中即可，这里使用快递100的`API`进行说明：

快递100的接口是：`http://www.kuaidi100.com/query?type=yunda&postid=3100074176480`，首先在`LocalServer`文件夹中新建一个`query`文件，在文件中把`JSON`格式的数据粘贴进去。然后修改`APIConfig.h`中的`LOCAL_SERVER_ISOPEN`为`YES`,此时再调用该接口，即是读取本地`query`文件。另外，需要注意的是，不管接口的路径有多少复杂，例如`query/query/query`，在`LocalServer`文件夹中，只需要新建最后一个名称即可。

`2014.10.14更新`

集成友盟社会化分享插件，在程序内可实现一键分享和摇一摇截图分享，特别要注意的是，微信分享时，需要把`URL Schemes`设置为申请的`key`值，这样才不会出现返回至应用程序错乱的情况。
[![](http://ftpdemo.qiniudn.com/Umeng.1.png)](http://ftpdemo.qiniudn.com/Umeng.1.png)


`2014.10.13更新`

集成`Crittercism`，目前版本`5.0.4`。如果`SDK`有更新，可直接替换`${SRCROOT}/Common/CrittercismSDK`即可。申请新的`App`后，把对应的`APP_ID和API_KEY`复制到`Crittercism.xcconfig`里.

格式如下:


`APP_ID=543b8df7bb94751247000002`

`API_KEY=RpiMACqaFPcvWtn09H2P1MKgPlihcAP8`


在`AppDelegate.m`里，使用如下代码进行处理
```objetivce-c
[Crittercism enableWithAppID:[AppUtils getcrittercismKey] andDelegate:nil];
```



通过读取`Crittercism.xcconfig`里的`APP_ID`来进行处理，代码写的比较搓，先将就着用吧。另外，还需要进行如下配置
[![](http://ftpdemo.qiniudn.com/1.png)](http://ftpdemo.qiniudn.com/1.png)


## 使用说明
1.网络请求发送
```objetivce-c
NSMutableDictionary *param = [NSMutableDictionary new];
[param setObject:@"yunda" forKey:@"type"];
[param setObject:@"3100074176480" forKey:@"postid"];

[[RTHttpClient manager]
requestWithPath:[[APIConfig manager] getAPIURL:API_LOGIN]
method:RTHttpRequestGet
parameters:param
prepareExecute: ^{}

success: ^(NSURLSessionDataTask *task, id responseObject) {
KuaiDi *kd = [KuaiDi modelObjectWithDictionary:responseObject];
NSLog(@"response: %@", kd);
}

failure: ^(NSURLSessionDataTask *task, NSError *error) {
NSLog(@"Error: %@", error);
}];
```



## License

`This code is distributed under the terms and conditions of the [MIT license](LICENSE). `


