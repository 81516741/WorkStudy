//
//  main.cpp
//  04
//
//  Created by ld on 16/10/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#include <iostream>
#include <vector>

int main(int argc, const char * argv[]) {
    using std::cin;
    using std::cout;
    using std::string;
    string line1;
    string line2;
    while (true) {
        getline(cin, line1);
        getline(cin, line2);
        if (line1 == line2) {
            cout << "相等";
        }else{
            cout << "不相等";
        }
        if (line1.size() > line2.size()) {
            cout << "line1长";
        }
        if (line1.size() == line2.size()) {
            cout << "一样长";
        }
        
        std::vector<string> svec2(10);
        cout << svec2.size();
        std::vector<int> ints = {1,2,3,4,5,5};
        std::vector<int> intss(4,1);
        
        std::vector<string>::iterator iter = svec2.end();
    }

    return 0;
}
