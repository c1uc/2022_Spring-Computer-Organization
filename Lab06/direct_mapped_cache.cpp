#include "direct_mapped_cache.h"
#include "string"
#include <fstream>
#include <vector>
typedef unsigned long long ull;

using namespace std;

float direct_mapped(string filename, int block_size, int cache_size)
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
    tmp = block_count;
    int index_len = 0;
    while(tmp > 1) {
        tmp >>= 1;
        index_len++;
    }
    int tag_len = 32 - index_len - offset;

    vector<bool> valid(block_count, 0);
    vector<ull> tags(block_count, 0);

    ifstream fin;
    fin.open (filename, ios::binary);
    string s;
    while(fin >> s) {
        total_num++;
        ull add = stoull(s, nullptr, 16);
        ull tag = add >> (32 - tag_len);
        ull idx = (add % ((ull)1 << (index_len + offset))) >> offset;
        if(valid[idx]) {
            if(tags[idx] == tag) {
                hit_num++;
            } else {
                tags[idx] = tag;
            }
        } else {
            valid[idx] = 1;
            tags[idx] = tag;
        }
    }
    fin.close();
    return (float)hit_num/total_num;
}
