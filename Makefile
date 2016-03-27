#target
TARGET = other1
#-----------------------------------------------------
#源代码文件子目标文件1
SOURCE1 = other1.c
OBJS1 = other1.o
#源代码文件子目标文件2
SOURCE2 = 
OBJS2 =
#源代码文件子目标文件3
SOURCE3 = 
OBJS3 =
#源代码文件子目标文件4
SOURCE4 = 
OBJS4 =
#------------------------------------------------------
#目标文件列表
OBJS = $(OBJS1)  $(OBJS2)  $(OBJS3)  $(OBJS4)
#OBJS := $(OBJS1)
#OBJS += $(OBJS2)
#OBJS += $(OBJS3)
#OBJS += $(OBJS4)
#头文件列表
HDRS =
#------------------------------------------------------
#通用规则
$(TARGET):$(OBJS) $(HDRS)
	gcc $(OBJS) $(HDRS) -o $(TARGET)

#根据不同的源文件创建目标文件,这个需要根据不同项目来修改
OBJS1:SOURCE1
	gcc -c SOURCE1
OBJS2:SOURCE2
	gcc -c SOURCE2
OBJS3:SOURCE3
	gcc -c SOURCE3
OBJS4:SOURCE4
	gcc -c SOURCE4
#all:howdy

#伪目标,用来删除目标文件和二进制可执行文件
.PHONY:clean
clean:
	rm $(TARGET) *.o

