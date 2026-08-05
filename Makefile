# 디렉토리 경로
SRC_DIR = src
INC_DIR = include
OBJ_DIR = build

# 컴파일러 및 옵션
CC = gcc
# -I$(INC_DIR): 헤더 파일(.h)을 include 폴더에서 찾으라고 지시
CFLAGS = -Wall -pthread -I$(INC_DIR)
LIBS = -lwiringPi

# 실행 파일 이름
TARGET = sentry_system

# src 폴더의 모든 .c 파일을 찾음
SRCS = $(wildcard $(SRC_DIR)/*.c)
# .c 파일 목록을 .o 파일 목록으로 변환 (build 폴더 밑으로)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))



# 'make' 입력 시 실행되는 기본 타겟
all: create_dir $(TARGET)

# build 폴더 생성 (없으면 에러 나니까)
create_dir:
	@mkdir -p $(OBJ_DIR)

# 실행 파일 생성 (링크)
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

# 개별 소스 파일 컴파일 (.c -> .o)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# 청소 (make clean)
clean:
	rm -rf $(OBJ_DIR) $(TARGET)