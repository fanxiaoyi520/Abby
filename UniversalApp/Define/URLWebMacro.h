//
//  URLWebMacro.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/19.
//  Copyright © 2022 徐阳. All rights reserved.
//

#ifndef URLWebMacro_h
#define URLWebMacro_h

#define WEBDevelopSever    0
#define WEBTestSever       1
#define WEBProductSever    0

#if WEBDevelopSever

/**开发服务器*/
#define WEB_URL_main @"http://10.125.26.6:9998/html"

#elif WEBTestSever

/**测试服务器*/
#define WEB_URL_main @"http://10.125.26.6:9998/html"

#elif WEBProductSever

/**生产服务器*/
#define WEB_URL_main @"http://10.125.26.6:9998/html"
#endif


#define web_url_privacyPolicy @"/privacyPolicy.html"
#define web_url_personal @"/personal.html"
#define web_url_cancle @"/cancle.html"
#define web_url_directions @"/directions.html"
#define web_url_guide @"/guide.html"
#define web_url_installationNotes @"/installationNotes.html"

#endif /* URLWebMacro_h */

