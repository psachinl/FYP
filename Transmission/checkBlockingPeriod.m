function blocked = checkBlockingPeriod(src,t)
    if t-src.last_broadcast_time < src.broadcast_delay
        blocked = true;
    else
        blocked = false;
    end
end