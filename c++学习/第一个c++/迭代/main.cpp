//
//  main.cpp
//  迭代
//
//  Created by ld on 16/10/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#include <iostream>
#include <vector>
int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    std::vector<std::string> strings(10);
    using std::string;
    for (std::vector<std::string>::size_type i = 0; i != strings.size(); i ++) {
        
        char c[4];
        sprintf(c, "%lu",i);
        strings[i] = c;
        
    }
    ;
    std::vector<std::string> :: iterator iter = strings.begin();
    std::vector<std::string> :: const_iterator iter1 = strings.begin();
    std::cout << *++iter1 << std::endl;
    
    std::cout << strings[0] << std::endl;
    std::cout << *++iter << std::endl;
    return 0;
}
