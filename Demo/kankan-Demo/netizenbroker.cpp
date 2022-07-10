#include "netizenbroker.h"
#include "netizen.h"
#include <iostream>

NetizenBroker* NetizenBroker::m_netizenBroker = nullptr;
std::mutex NetizenBroker::m_mutex = {};
std::unordered_map<long, Netizen> NetizenBroker::_newClean = {};
std::unordered_map<long, Netizen> NetizenBroker::_newDirty = {};
std::unordered_map<long, Netizen> NetizenBroker::_newDelete = {};
std::unordered_map<long, Netizen> NetizenBroker::_oldClean = {};
std::unordered_map<long, Netizen> NetizenBroker::_oldDirty = {};
std::unordered_map<long, Netizen> NetizenBroker::_oldDelete = {};

NetizenBroker::NetizenBroker()
{

}

NetizenBroker::~NetizenBroker()
{

}

NetizenBroker *NetizenBroker::getInstance()
{
    if (m_netizenBroker == nullptr)
        m_netizenBroker = new NetizenBroker();
    return m_netizenBroker;
}

bool NetizenBroker::qualifyNetizenId(long id)
{
    //根据id查找,如果找到返回true,否则返回false
    std::string sql = "select user_id from user";
    std::shared_ptr<sql::ResultSet> res = query(sql);
    while (res->next()) {
        if (id == res->getInt(1))
            return true;
    }

    return false;
}

void NetizenBroker::cacheFlush()
{
    std::string sql = "insert into user values ";
    for(auto iter = _newClean.begin(); iter != _newClean.end();){

        //应该保证当进行插入时，数据是不可以被其他线程所更改的
        std::lock_guard<std::mutex> lk(m_mutex);

        sql += "(" + std::to_string(iter->first) + ",'"+ iter->second.key()+ "','"+ iter->second.nickname()+ "'),";

        //从对应缓存中删除相关数据
        //erase的返回值是一个迭代器，指向删除元素下一个元素。
        _newClean.erase(iter++);
    }

    for(auto it = _newDirty.begin(); it != _newDirty.end();){

        //应该保证当进行插入时，数据是不可以被其他线程所更改的
        std::lock_guard<std::mutex> lk(m_mutex);

        sql += "("+ std::to_string(it->first) + ",'" + it->second.key() + "','" + it->second.nickname() + "'),";

        //从对应缓存中删除相关数据
        //erase的返回值是一个迭代器，指向删除元素下一个元素。
        _newClean.erase(it++);
    }

    if (!sql.empty()) sql.pop_back();
    insert(sql);   //执行批量插入，插入新的净缓存和新的脏缓存中的数据
}
void NetizenBroker::cacheDel()
{
    for(auto iter = _newDelete.begin(); iter != _newDelete.end();){

        //应该保证当进行插入时，数据是不可以被其他线程所更改的
        std::lock_guard<std::mutex> lk(m_mutex);

        //从对应缓存中删除相关数据
        //erase的返回值是一个迭代器，指向删除元素下一个元素。
        _newDelete.erase(iter++);
    }

    for(auto it = _oldDelete.begin(); it != _oldDelete.end();){

        //应该保证当进行插入时，数据是不可以被其他线程所更改的
        std::lock_guard<std::mutex> lk(m_mutex);

        std::string sql = "delete from user where id=" + std::to_string(it->first);
        del(sql);
        //从对应缓存中删除相关数据
        //erase的返回值是一个迭代器，指向删除元素下一个元素。
        _oldDelete.erase(it++);
    }
}
void NetizenBroker::cacheUpdate()
{

}

void NetizenBroker::flush()
{
    cacheFlush();
    cacheDel();
    cacheUpdate();
}

bool NetizenBroker::qualifyNetizenKey(long id, std::string key)
{
    //验证对应id的密码，正确返回true,错误返回false
    std::string sql = "select user_id, user_key from user";
    std::shared_ptr<sql::ResultSet> res = query(sql);
    while (res->next()) {
        if (id == res->getInt(1) && key == res->getString(2))
            return true;
    }

    return false;
}

void NetizenBroker::insertNewNetizen(std::shared_ptr<Netizen> netizen)
{
    std::string sql = netizen->insertSql();
    std::cout << sql << std::endl;
    insert(sql);
}

std::shared_ptr<Netizen> NetizenBroker::findNetizenById(long id)
{
    //检查用户是否在缓存中

    //查找数据库，找出用户的nickname
    std::string nickname;

    std::string sql = "select user_nickname from user where user_id = " + std::to_string(id);
    std::shared_ptr<sql::ResultSet> res = query(sql);
    while (res->next())
        nickname = res->getString(1).c_str();
    std::cout << "用户名：" << nickname << std::endl;

    //调用Netizen(id, nickname, videosId, fansId, followersId);
    std::shared_ptr<Netizen> netizen = std::make_shared<Netizen>(id, "www.cv",nickname, findNetizenVideos(id), findNetizenFans(id), findNetizenFollowers(id));

    std::cout << "Netizen对象实例化成功" << std::endl;

    return netizen;
}

std::vector<std::string> NetizenBroker::findNetizenVideos(const long id)
{
    std::string sql = "select id from video where user_id = " + std::to_string(id);
    std::shared_ptr<sql::ResultSet> res = query(sql);
    std::vector<std::string> videoIds;
    while (res->next()) {
        videoIds.push_back(res->getString(1).c_str());
    }

    return videoIds;
}

std::vector<long> NetizenBroker::findNetizenFans(const long id)
{
    std::string sql = "select fan_id from fan where user_id = " + std::to_string(id);
    std::shared_ptr<sql::ResultSet> res = query(sql);
    std::vector<long> fanIds;
    while (res->next()) {
        fanIds.push_back(res->getLong(1));
    }

    return fanIds;
}

std::vector<long> NetizenBroker::findNetizenFollowers(const long id)
{
    std::string sql = "select follower_id from follower where user_id = " + std::to_string(id);
    std::shared_ptr<sql::ResultSet> res = query(sql);
    std::vector<long> followerIds;
    while (res->next()) {
        followerIds.push_back(res->getLong(1));
    }

    return followerIds;
}


