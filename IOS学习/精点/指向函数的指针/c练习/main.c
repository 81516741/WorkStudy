//
//  main.c
//  c练习
//
//  Created by Kingpoint on 16/1/14.
//  Copyright © 2016年 kingpoint. All rights reserved.
//

#include <stdio.h>

int func(int,int);

int main(int argc, const char * argv[]) {
    int (*p)(int,int) = &func;
    struct date{
        int age;
        char * name;
    };
    //两种方式都可以
    int sum = (*p)(2,3);
    sum = p(3,6);
    printf("%d\n",sum);
    return 0;
}

int func(int a,int b)
{
    return a + b;
}