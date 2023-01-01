NAME := hellocpp20

CXX := g++
CXXFLAGS := -std=c++20 -fmodules-ts


SRC_DIR := src
BUILD_DIR := build

SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
HEADERS := $(wildcard $(SRC_DIR)/*.h)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SOURCES))


STD_MODULES := iostream algorithm
GCM_CACHE := gcm.cache/usr/include/c++/12
STD_OBJECTS := $(addprefix $(GCM_CACHE)/, $(addsuffix .gcm, $(STD_MODULES)))

###
#
# Targets
#
###

all: $(BUILD_DIR)/$(NAME)

$(BUILD_DIR)/$(NAME): $(STD_OBJECTS) $(OBJECTS)
	$(CXX) $(OBJECTS) $(CXXFLAGS) -o $@

$(GCM_CACHE)/%.gcm:
	$(CXX) $(CXXFLAGS) -x c++-system-header $(@:$(GCM_CACHE)/%.gcm=%)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS) 
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

run: $(BUILD_DIR)/$(NAME)
	$(BUILD_DIR)/$(NAME)

clean:
	rm -rf $(BUILD_DIR) gcm.cache

.PHONY: clean all
