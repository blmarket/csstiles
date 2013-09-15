#include <iostream>
#include <string>
#include <iterator>
#include <algorithm>
#include <fstream>

using namespace std;

#include "rltiles/tiledef-dngn.h"
#include "rltiles/tiledef-player.h"
#include "rltiles/tiledef-feat.h"

template<typename T> int size(const T &a) { return a.size(); }

template<typename T1, typename T2>
void write_list(const string &type_name, 
        int begin, int end, 
        const T1 &name_func, const T2 &info_func) {

    cout << '"' << type_name << "\":";
    cout << "[";
    for(int i=begin;i<end;i++) {
        string name = name_func(i);
        for(int j=0;j<size(name);j++) {
            name[j] = tolower(name[j]);
        }
        if(type_name == name) continue;
        cout << '"' << name << '"';
        if(i+1 < end) cout << ',';
    }
    cout << "]";
}

void write_main_css(void) {
    write_list("main", 0, TILE_MAIN_MAX,
            tile_main_name, tile_main_info);
}

void write_player_css(void) {
    write_list("player", TILE_MAIN_MAX, TILEP_PLAYER_MAX,
            tile_player_name, tile_player_info);
}

void write_floor_css(void) {
    write_list("floor", 0, TILE_FLOOR_MAX,
            tile_floor_name, tile_floor_info);
}

void write_wall_css(void) {
    write_list("wall", TILE_FLOOR_MAX, TILE_WALL_MAX,
            tile_wall_name, tile_wall_info);
}

void write_feat_css(void) {
    write_list("feat", TILE_WALL_MAX, TILE_FEAT_MAX, 
            tile_feat_name, tile_feat_info);
}

int main(void)
{
    cout << "{";
    write_main_css();
    cout << ",";
    write_player_css();
    cout << ",";
    write_floor_css();
    cout << ",";
    write_wall_css();
    cout << ",";
    write_feat_css();
    cout << "}";
    return 0;
}
