//
//  main.cpp
//  c++-03
//
//  Created by ld on 16/10/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    // insert code here...
    int a,b,c=1;
    
    using std::cout;
    using std::cin;
    using std::endl;
    
    std::string name = "nimei";
    std::cout << name;
    std::cout << "请输入底数\n";
    
    std::cin >> a;
    std::cout << "请输入指数\n";
    std::cin >> b;
    for (int i = 0; i < b; i ++) {
        c = a * c;
    }
    std::cout << a ;
    std::cout << "结果是" << c << std:: endl;
    
     int aa = 0;
    int bb = 2;
     int  &aaa = aa;
    aaa = bb;
    
    std::cout << aa;
    cout << "哈哈";
    using std::string;
    string str("");
    
    string line;
    // read line at time until end-of-file
    string line1;
    cin >> line1;
    cout << line1;
    
    while (getline(cin, line))
        cout << line << endl;
    
    return 0;
}

class Book{
public:
private:
    std::string name;
    unsigned age;
    unsigned price;
};
