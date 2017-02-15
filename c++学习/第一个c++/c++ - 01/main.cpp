//
//  main.cpp
//  c++ - 01
//
//  Created by ld on 16/9/27.
//  Copyright © 2016年 ld. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    // 求和
    int a = 0,sum = 0;
    while (a < 10) {
        a++;
        std::cout << a << std::endl;
        sum = sum + a;
    }
    std::cout << sum;
    std::cout << std::endl;
    
    int result = 0;
    for (int i = 1; i <= 10; i ++) {
        result = result + i;
    }
    std::cout << result << std::endl;
    
    int result1 = 0;
    for (int i =  -100 ; i <= 100; ++i) {
        result1 += i ;
    }
    std::cout << "result1 = " << result1 << std::endl;
    
    int val = 0;
    std::cin >> val;
    while ( val < 0) {
        std::cerr << "输入的值小于0，请重新输入" << std::endl;
        std::cin >> val;
    }
    
    
    
    return 0;
}
