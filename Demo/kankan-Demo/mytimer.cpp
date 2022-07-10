#include "mytimer.h"



MyTimer::MyTimer(const MyTimer &timer)
{
    _expired = timer._expired.load();
    _try_to_expire = timer._try_to_expire.load();
}

void MyTimer::start(int interval, std::function<void ()> task)
{
    // is started, do not start again
    if (_expired == false)
        return;

    // start async timer, launch thread and wait in that thread
    _expired = false;
    std::thread([this, interval, task]() {
        while (!_try_to_expire)
        {
            // sleep every interval and do the task again and again until times up
            std::this_thread::sleep_for(std::chrono::milliseconds(interval));
            task();
        }

        {
            // timer be stopped, update the condition variable expired and wake main thread
            std::lock_guard<std::mutex> locker(_mutex);
            _expired = true;
            _expired_cond.notify_one();
        }
    }).detach();  //主调线程继续运行，被调线程驻留后台运行，主调线程无法再取得该被调线程的控制权
}

void MyTimer::stop()
{
    // do not stop again
    if (_expired)
        return;

    if (_try_to_expire)
        return;

    // wait until timer
    _try_to_expire = true; // change this bool value to make timer while loop stop
    {
        std::unique_lock<std::mutex> locker(_mutex);
        _expired_cond.wait(locker, [this] {return _expired == true; });

        // reset the timer
        if (_expired == true)
            _try_to_expire = false;
    }
}
