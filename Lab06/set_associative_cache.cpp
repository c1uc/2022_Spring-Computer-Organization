#include "set_associative_cache.h"
#include "string"
#include <fstream>
#include <vector>
typedef unsigned long long ull;

using namespace std;

float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = 0;
    int hit_num = 0;

    /*write your code HERE*/
    int tmp = block_size;
    int block_count = cache_size / block_size;
    int offset = 0;
    while(tmp > 1) {
        tmp >>= 1;
        offset++;
    }
    tmp = block_count / way;
    int index_len = 0;
    while(tmp > 1) {
        tmp >>= 1;
        index_len++;
    }
    int tag_len = 32 - index_len - offset;

    vector<vector<bool>> valid(block_count, vector<bool>(way, 0));
    vector<vector<ull>> tags(block_count, vector<ull>(way, 0));
    vector<vector<int>> used(block_count, vector<int>(way, 0));

    ifstream fin;
    fin.open (filename, ios::binary);
    string s;
    while(fin >> s) {
        total_num++;
        bool flag = 0;
        ull add = stoull(s, nullptr, 16);
        ull tag = add >> (32 - tag_len);
        ull idx = (add % ((ull)1 << (index_len + offset))) >> offset;
        for(int i = 0;i < way && !flag;i++) {
            if(valid[idx][i] && tags[idx][i] == tag) {
                used[idx][i] = total_num;
                hit_num++;
                flag = 1;
            } else if(!valid[idx][i]) {
                valid[idx][i] = 1;
                used[idx][i] = total_num;
                tags[idx][i] = tag;
                flag = 1;
            }
        }
        if(!flag) {
            int last = 0, lastu = used[idx][0];
            for(int i = 1;i < way;i++) {
                if(used[idx][i] < lastu) last = i, lastu = used[idx][i];
            }
            tags[idx][last] = tag;
            used[idx][last] = total_num;
        }
    }
    fin.close();
    return (float)hit_num/total_num;
}
