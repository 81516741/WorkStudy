//
//  main.m
//  c语言NO.1
//
//  Created by ld on 16/9/12.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <stdio.h>
#import <math.h>
#import <string.h>

void func1();
void * f11();
extern int a;
void func4(int * p1,int * p2);
int main(int argc, const char * argv[]) {
    //函数指针
    int a = 10,b = 20;
    void (*f)(int*,int*);
    f = func4;
    (*f)(&a,&b);
    
    //数组元素排序
    void func5(char *name[],int n);
    char * name[] = {"zeng","ling","da","hai","rong","chang","e"};
    func5(name, 7);
    
    //指针的指针
    char *name1[] = {"nihao","woshizhzhen","ddddd"};
    char **p;
    for (int i = 0; i < 3; i ++) {
        p = name1 + i;
        printf("%s\n",*p);
    }
    
    int arr[] = {1,2,3,4};
    int *pArr[] = {&arr[0],&arr[1],&arr[2],&arr[3]};
    int **p1 = pArr;
    for (int i = 0; i < 4; i ++) {
        printf("%d\n",**p1);
        p1 = p1 + 1;
    }
    
    
    int arr2[2][3] = {{1,2,3},{5,6,7}};
    int *p3 = arr2[0];
    int **p4 = &p3;
    printf("hahah---%d\n",*(p3+5));
    return 0;
}

void func5(char *name[],int n)
{
    for (int i = 0; i < n - 1; i ++) {
        for (int j = 0; j < n - 1 - i; j ++) {
            if(strcmp(name[j], name[j+1]) > 0){
                char * temp = name[j + 1];
                name[j + 1] = name[j];
                name[j] = temp;
            }
        }
    }
}

void func4(int * p1,int * p2){
    int temp = *p1;
    *p1 = *p2;
    *p2 = temp;
}
int a = 0;
void func3(){
    int a[][4] = {32,34,54,65,
        43,546,23,64,
        323,443,11,43};
    int b[3];
    for (int i = 0; i < 3; i ++) {
        int temRMax = 0;
        for (int j = 0; j < 4; j ++) {
            if (a[i][j] > temRMax) {
                temRMax = a[i][j];
            }
        }
        b[i] = temRMax;
    }
}
void func2(){
    
    char str1[100] = "nihao";
    printf("%s\n",str1);
    char str2[10];
    gets(str2);
    strcat(str1, str2);
    printf("%s\n",str1);
}

void func1(){
    float s ,s1 ,s2 ,s3 ,area;
    printf("请输入三角形的3条边长");
    scanf("%f %f %f",&s1,&s2,&s3);
    s = (s1 + s2 + s3)/2.0;
    area = sqrtf(s*(s - s1)*(s - s2)*(s - s3));
    printf("%f",area);

}