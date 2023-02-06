#include<stdio.h>
int write_file(){
	FILE* fp = NULL;

	//1. 打开文件
	fp = fopen("/home/ubuntu/git/Miscellaneous/07C文件/test.txt","w");
	if(fp == NULL){
		perror("fopen");
		return -1;
	}
	//2. 写文件
	fputc('a', fp);
	fputc('b', fp);
	fputc('c', fp);

	//3. 关闭文件
	fclose(fp);
	fp = NULL;
	return 0;
}
int read_file(){

	//1. 打开文件
	FILE* fp;
	fp = fopen("/home/ubuntu/git/Miscellaneous/07C文件/test.txt","r");
	if(fp==NULL){
		perror("fopen");
		return -1;
	}

	//2. 读文件
	char ch;
	/*
	ch = fgetc(fp);
	printf("%c \n", ch);
	ch = fgetc(fp);
	printf("%c \n", ch);
	ch = fgetc(fp);
	printf("%c \n", ch);
	ch = fgetc(fp);
	printf("%c \n", ch);
	*/
	while(1){
		ch = fgetc(fp);
		printf("%c\n",ch);
		//if(ch == -1){
		//if(ch == EOF){
		if(feof(fp)){
			break;
		}
	}

	//3. 关闭文件
	fclose(fp);
	fp = NULL;
	return 0;
}


// 使用fgetchar()函数接收键盘逐个输入字符，写到磁盘文件，知道用户输入 # 为止
int gpc(){ 
	
	//1. 打开文件
	FILE* fp;
	char filename[10];
	printf("请输入文件名:");
	scanf("%s",filename);
	fp = fopen(filename,"w");
	if(fp == NULL){
		perror("fopen");
		return -1;
	}	
	//2. 读写文件
	
	char ch;
	printf("请输入一个准备存储到磁盘的字符串：（#结束）");
	ch = getchar();
	while(ch != '#'){
		fputc(ch, fp);
		putchar(ch);
		ch = getchar(); //准备接收用户下一次输入
	}

	//3. 关闭文件
	fclose(fp);
	fp = NULL;
	return 0;
}

int main(){
	write_file();
	read_file();

	gpc();
	return 0;
}
