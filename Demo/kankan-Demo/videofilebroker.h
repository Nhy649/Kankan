#ifndef VIDEOFILEBROKER_H
#define VIDEOFILEBROKER_H

#include "relationalbroker.h"
#include "videofile.h"
#include <mutex>
class VideoFileBroker : public RelationalBroker
{
public:
    virtual ~VideoFileBroker();
    static VideoFileBroker* getInstance();
    static void flush();
    std::shared_ptr<VideoFile> getVideoFile(std::string& id);
private:
    VideoFileBroker();
    static VideoFileBroker* m_videoFileBroker;
    static std::mutex m_mutex;
    static std::unordered_map<std::string, VideoFile> _newClean;  //新的净缓存
    static std::unordered_map<std::string, VideoFile> _newDirty;  //新的脏缓存
    static std::unordered_map<std::string, VideoFile> _newDelete; //新的删除缓存
    static std::unordered_map<std::string, VideoFile> _oldClean;  //旧的净缓存
    static std::unordered_map<std::string, VideoFile> _oldDirty;  //旧的脏缓存
    static std::unordered_map<std::string, VideoFile> _oldDelete; //旧的删除缓存

    static void cacheFlush();    //将数据写入数据库
    static void cacheDel();      //删除数据库中的数据
    static void cacheUpdate();   //修改数据库中的数据
    static VideoFile* inCache(std::string id);   //判断是否在缓存中
};

#endif // VIDEOFILEBROKER_H
