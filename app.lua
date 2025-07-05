paddley = 5
ball = {math.random(20, 290), math.random(20, 380)}
ballvel = {math.random(1, 10), math.random(1, 10)}
lost = false

function checkIfTouching()
    -- inverting the x: ballvel[1] = -ballvel[1]
    -- inverting the y: ballvel[2] = -ballvel[2]
    -- when the ball hits the roof or the ground, invert the Y
    -- when the ball hits the paddle or the wall, invert the X
    -- min x: 10
    -- max x: 310
    -- min y: 0
    -- max y: 480
    if (ball[2] >= -1 and ball[2] <= 11) or (ball[2] <= 481 and ball[2] >= 469) then
        ballvel[2] = -ballvel[2]
    elseif ball[1] >= 299 then
        ballvel[1] = -ballvel[1]
    elseif ball[1] <= 21 then
        if paddley < ball[2]+25 and paddley > ball[2]-50 then
            ballvel[1] = -ballvel[1]
        else
            lost = true
            quit()
        end
    end
end

function updateBall()
    ball[1] = ball[1] + ballvel[1]
    ball[2] = ball[2] + ballvel[2]
    checkIfTouching()
    canvas:fillCircle(ball[1], ball[2], 5, COLOR_WHITE)
end

function update()
    if (not lost) then
        canvas:fillRect(0, 0, 360, 480, COLOR_DARK)
        updateBall()
        canvas:fillRoundRect(5, paddley, 5, 50, 5, COLOR_WHITE)
        canvas:fillRect(310, 0, 10, 480, COLOR_WHITE)
    end
end

function run()
    win = gui:window()
    canvas = gui:canvas(win, 0, 0, 360, 480)
    canvas:fillRect(0, 0, 360, 480, COLOR_DARK)
    updateBall()
    canvas:onTouch(function(a)
        paddley = a[2]
    end)
    time:setInterval(update, 1)

    gui:setWindow(win)
end