---------------------------------------------------------
-- ATRAPA MANZANAS (VERSIÓN CORREGIDA FINAL)
---------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
physics.start()
physics.setGravity(0,0)

local cx = display.contentCenterX
local cy = display.contentCenterY
local W  = display.contentWidth
local H  = display.contentHeight

---------------------------------------------------------
-- VARIABLES
---------------------------------------------------------
local score = 0
local manzanas = 0
local vidas = 3
local velocidad = 4
local jugando = true

local gameOverText, botonReiniciar, textoBoton
local apple

---------------------------------------------------------
-- SONIDO
---------------------------------------------------------
local sonido = audio.loadSound("Bite.mp3")

---------------------------------------------------------
-- FONDO
---------------------------------------------------------
local fondo = display.newImageRect("bosque.jpg", W, H)
fondo.x = cx
fondo.y = cy

---------------------------------------------------------
-- AVE
---------------------------------------------------------
local bird = display.newImageRect("parrot-a.png", 60, 60)
bird.x = cx
bird.y = H - 70

physics.addBody(bird, "kinematic", {radius=25})

---------------------------------------------------------
-- ANIMACIÓN (ALETERO REAL)
---------------------------------------------------------
local frame = true
timer.performWithDelay(150, function()
    if bird and bird.removeSelf ~= nil then
        if frame then
            bird.fill = { type="image", filename="parrot-a.png" }
        else
            bird.fill = { type="image", filename="parrot-b.png" }
        end
        frame = not frame
    end
end, 0)

---------------------------------------------------------
-- TEXTOS
---------------------------------------------------------
local scoreText = display.newText("Puntos: 0", 90, 30, native.systemFont, 20)
local vidasText = display.newText("Vidas: 3", W - 90, 30, native.systemFont, 20)
local manzanaText = display.newText("Manzanas: 0", cx, 60, native.systemFont, 18)

---------------------------------------------------------
-- CREAR MANZANA
---------------------------------------------------------
local function nuevaManzana()

    if apple then
        apple:removeSelf()
    end

    local img = (math.random(1,2) == 1) and "apple.png" or "apple2.png"

    apple = display.newImageRect(img, 40, 40)
    apple.x = math.random(40, W-40)
    apple.y = -20

    physics.addBody(apple, "dynamic", {radius=20, isSensor=true})
    apple.gravityScale = 0
end

---------------------------------------------------------
-- MOVIMIENTO (AHORA SÍ BIEN)
---------------------------------------------------------
local function mover(event)
    if jugando then
        bird.x = event.x
    end
    return true
end

Runtime:addEventListener("touch", mover)

---------------------------------------------------------
-- COLISION (MEJOR DETECCIÓN)
---------------------------------------------------------
local function onCollision(event)
    if event.phase == "began" then
        
        if (event.object1 == bird and event.object2 == apple) or
           (event.object1 == apple and event.object2 == bird) then
            
            manzanas = manzanas + 2
            score = score + 10

            scoreText.text = "Puntos: " .. score
            manzanaText.text = "Manzanas: " .. manzanas

            audio.play(sonido)

            velocidad = velocidad + 1.0

            nuevaManzana()
        end
    end
end

Runtime:addEventListener("collision", onCollision)

---------------------------------------------------------
-- GAME OVER
---------------------------------------------------------
local function gameOver()
    jugando = false

    gameOverText = display.newText("GAME OVER", cx, cy - 40, native.systemFont, 40)
    gameOverText:setFillColor(1,0,0)

    botonReiniciar = display.newRect(cx, cy + 40, 180, 60)
    botonReiniciar:setFillColor(0, 0.6, 0)

    textoBoton = display.newText("REINICIAR", cx, cy + 40, native.systemFont, 20)

    botonReiniciar:addEventListener("tap", function()
        
        -- eliminar TODO correctamente
        if gameOverText then gameOverText:removeSelf() end
        if botonReiniciar then botonReiniciar:removeSelf() end
        if textoBoton then textoBoton:removeSelf() end

        score = 0
        manzanas = 0
        vidas = 3
        velocidad = 4
        jugando = true

        scoreText.text = "Puntos: 0"
        vidasText.text = "Vidas: 3"
        manzanaText.text = "Manzanas: 0"

        nuevaManzana()

        Runtime:addEventListener("enterFrame", gameLoop)
    end)

    Runtime:removeEventListener("enterFrame", gameLoop)
end

---------------------------------------------------------
-- LOOP
---------------------------------------------------------
function gameLoop()

    if not jugando then return end

    if apple then
        apple.y = apple.y + velocidad

        if apple.y > H then
            vidas = vidas - 1
            vidasText.text = "Vidas: " .. vidas

            if vidas <= 0 then
                gameOver()
            else
                nuevaManzana()
            end
        end
    end
end

---------------------------------------------------------
-- COLISIÓN ACTIVADA CORRECTAMENTE
---------------------------------------------------------
function onCollision(event)
    if (event.object1 == bird and event.object2 == apple) or
       (event.object1 == apple and event.object2 == bird) then
        
        colision()
    end
end

Runtime:addEventListener("collision", onCollision)

---------------------------------------------------------
-- INICIO
---------------------------------------------------------
nuevaManzana()
Runtime:addEventListener("enterFrame", gameLoop)