//
//  main.cpp
//  位
//
//  Created by ld on 16/10/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    using std::string;
    using std::bitset;
    string str("1100");
    bitset<32> bitvec5(str);
    std::cout << bitvec5[2] << std::endl;
    
    bitset<64> bitvec(0b101010);
    for (int i = 0; i < bitvec.size(); i ++) {
        std::cout << "----"<< bitvec[i] << std::endl;
    }
    return 0;
}
