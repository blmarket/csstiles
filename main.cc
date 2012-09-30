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

ostream& operator<< (ostream& ost, const tile_info &data) {
    return ost << (int)data.width << " " << (int)data.height << " " << (int)data.offset_x << " " << (int)data.offset_y << " " << data.sx << "," << data.sy << "," << data.ex << "," << data.ey << endl;
}

template<typename T1, typename T2>
void write_css(const string &type_name, 
        int begin, int end, 
        const T1 &name_func, const T2 &info_func) {

    ofstream fout((type_name + ".css").c_str());

    for(int i=begin;i<end;i++) {
        string name = name_func(i);
        for(int j=0;j<size(name);j++) {
            name[j] = tolower(name[j]);
        }
        if(type_name == name) continue;
        fout << "div." + type_name + "." << name << " {" << endl;
        const tile_info &info = info_func(i);
        //fout << tile_player_name(i) << " " << info << endl;
        fout << "top: " << 32 - info.height + info.offset_y << "px;\n";
        fout << "left: " << (int)info.offset_x << "px;\n";
        fout << "width: " << info.ex - info.sx << "px;\n";
        fout << "height: " << info.ey - info.sy << "px;\n";

        fout << "background-image: url('./" + type_name + ".png') -" << info.sx << " -" << info.sy << ";" << endl;
        fout << "}" << endl;
    }

    fout.close();
}

void write_main_css(void) {
    write_css("main", 0, TILE_MAIN_MAX,
            tile_main_name, tile_main_info);
}

void write_player_css(void) {
    write_css("player", TILE_MAIN_MAX, TILEP_PLAYER_MAX,
            tile_player_name, tile_player_info);
}

void write_floor_css(void) {
    write_css("floor", 0, TILE_FLOOR_MAX,
            tile_floor_name, tile_floor_info);
}

void write_wall_css(void) {
    write_css("wall", TILE_FLOOR_MAX, TILE_WALL_MAX,
            tile_wall_name, tile_wall_info);
}

void write_feat_css(void) {
    write_css("feat", TILE_WALL_MAX, TILE_FEAT_MAX, 
            tile_feat_name, tile_feat_info);
}

int main(void)
{
    write_main_css();
    write_player_css();
    write_floor_css();
    write_wall_css();
    write_feat_css();
    return 0;
}
