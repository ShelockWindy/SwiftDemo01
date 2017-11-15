#include<math.h>
static const double pi = 3.14159265358979324;

//
// Krasovsky 1940
//
// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
static const double a = 6378245.0;
static const double ee = 0.00669342162296594323;

static int outOfChina(double lat, double lon)
{
    if (lon < 72.004 || lon > 137.8347)
        return 1;
    if (lat < 0.8293 || lat > 55.8271)
        return 1;
    return 0;
}

static double transformLat(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
}

static double transformLon(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
}

/*
 World Geodetic System ==> Mars Geodetic System
 地球坐标系 (WGS-84) 到火星坐标系 (GCJ-02) 的转换
 */
void WGS84_to_GCJ02(double wgLat, double wgLon, double *mgLat,double *mgLon)
{
    if (outOfChina(wgLat, wgLon))
    {
        *mgLat = wgLat;
        *mgLon = wgLon;
        return;
    }
    double dLat = transformLat(wgLon - 105.0, wgLat - 35.0);
    double dLon = transformLon(wgLon - 105.0, wgLat - 35.0);
    double radLat = wgLat / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    *mgLat = wgLat + dLat;
    *mgLon = wgLon + dLon;
}

/*火星坐标系 (GCJ-02) 与百度坐标系 (BD-09) 的转换*/
static const double x_pi = pi * 3000.0 / 180.0;
void GCJ02_to_Baidu09(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}

void Baidu09_to_GCJ02(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}
/* 地球坐标系 (WGS-84) 与百度坐标系 (BD-09) 的转换*/
void WGS84_to_Baidu09(double wgLat, double wgLon, double *bd_lat, double *bd_lon)
{
    double gg_lat=0,gg_lon=0;
    /*先转为Google坐标，再转为Baidu坐标*/
    WGS84_to_GCJ02(wgLat, wgLon, &gg_lat, &gg_lon);
    GCJ02_to_Baidu09(gg_lat, gg_lon, bd_lat, bd_lon);
}
/*
 参考：
 google地图经纬度偏移修正算法完美解决方案 http://blog.sina.com.cn/s/blog_65bd7eef0100hu5o.html
 WGS84坐标转火星坐标（iOS篇） http://www.keakon.net/2011/07/02/WGS84%E5%9D%90%E6%A0%87%E8%BD%AC%E7%81%AB%E6%98%9F%E5%9D%90%E6%A0%87%EF%BC%88iOS%E7%AF%87%EF%BC%89
地球坐标系 (WGS-84) 到火星坐标系 (GCJ-02) 的转换算法 http://blog.csdn.net/coolypf/article/details/8686588
火星坐标系 (GCJ-02) 与百度坐标系 (BD-09) 的转换算法 http://blog.csdn.net/coolypf/article/details/8569813
IPhone中GPS定位地理(投影)坐标与屏幕坐标转换 http://blog.sina.com.cn/s/blog_7f4111350100u6er.html
 */