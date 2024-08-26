local PLUGIN = PLUGIN

--теперь самое интересное

local blurAmount = 0

function PLUGIN:RenderScreenspaceEffects()
  local client = LocalPlayer()
  local character = client:GetCharacter()
  
  if (!client:Alive() or !character) then
    return
  end

  local test = character:GetData("RadAmount", 0)

  local targetBlur = math.Clamp((test - 25) / 25, 0, 1)

  blurAmount = Lerp(FrameTime() * 5, blurAmount, targetBlur)

  if blurAmount > 0 then
    DrawMotionBlur(0.1, blurAmount, 0.01)
  end

end