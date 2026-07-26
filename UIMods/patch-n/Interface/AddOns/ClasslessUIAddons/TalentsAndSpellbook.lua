-- TalentsAndSpellbook.lua
-- Minimal: just show/hide the frames.

local selectedClass = nil
local selectedTree = nil

local function ACClasslessUI_Show()
    if not ACClasslessUIFrame then
      print("AC Classless UI Error: XML frames not yet loaded.")
      return
    end

    if ACClasslessDeathKnightButton then
        print("ACClasslessUI::Show -> Selecting Death knight spell book by default")
        ACClasslessClassButton_OnClick(ACClasslessDeathKnightButton)
    end

  ACClasslessUIFrame:Show()
end

local function ACClasslessUI_Hide()
  if ACClasslessUIFrame then
    ACClasslessUIFrame:Hide()
  end
end

local function ACClasslessUI_Toggle()
  if ACClasslessUIFrame and ACClasslessUIFrame:IsShown() then
    ACClasslessUI_Hide()
  else
    ACClasslessUI_Show()
  end
end

-- Called by ACClasslessUIFrame OnShow (from XML)
function ACClasslessUIFrame_OnShow(self)
  -- Ensure the child frames are visible when the container shows.
  ACClasslessUI_Show()
end

function ACClasslessTreeButton_OnClick(source)
    -- 1. Disable previous selection
    if selectedTree and selectedTree.SelectedTexture then
        print("Hiding old highlighted tree texture")
        selectedTree.SelectedTexture:Hide()
    end

    selectedTree = source

    -- 2. Enable current selection (glow effect)
    if selectedTree and selectedTree.SelectedTexture then
        print("Showing new highlighted tree  texture")
        selectedTree.SelectedTexture:Show()
    end

    -- 3. Selection Logic (Logic can now reach anywhere via ACClasslessUIFrame)
    local treeId = source:GetID()

    -- Example: Update the Talent Title text using the graph
    local talentFrame = ACClasslessUIFrame.TalentFrame
    if talentFrame and talentFrame.TitleText then
        talentFrame.TitleText:SetText("Tree " .. treeId)
    end

    print("Switched to Tree: " .. treeId)
end

function ACClasslessClassButton_OnClick(source)
    -- 1. Disable previous class selection
    if selectedClass and selectedClass.SelectedTexture then
        print("Hiding old class highlight")
        selectedClass.SelectedTexture:Hide()
    end

    selectedClass = source

    -- 2. Enable current class selection
    if selectedClass and selectedClass.SelectedTexture then
        print("Showing new class highlight")
        selectedClass.SelectedTexture:Show()
    end

    -- 3. Automatically select the first tree button using the internal graph
    -- We reach through the selector frame to the hardcoded button
    local treeSelector = ACClasslessUIFrame.TreeSelectorFrame
    if treeSelector then
        print("ClassButton::OnClick -> Found Tree Selector")
        -- Since you named the buttons $parentTreeTab1 etc in XML,
        -- and treeSelector is the parent, they are keys on it.
        local firstTree = treeSelector.TreeTab1
        if firstTree then
            print("ClassButton::OnClick -> Selecting first tree tab")
            ACClasslessTreeButton_OnClick(firstTree)
        end
    end
end


-- Click handlers referenced by XML; no-op for now so errors don't occur.
function ACClasslessSpellbook_PrevPage() end
function ACClasslessSpellbook_NextPage() end
function ACClasslessSpellButton_OnEnter(self) end
function ACClasslessSpellButton_OnClick(self, button) end

function ACClassless_SelectGlyph() end



-- Slash command to test
SLASH_ACCLASSLESSUI1 = "/acui"
SlashCmdList["ACCLASSLESSUI"] = function(msg)
  ACClasslessUI_Toggle()
end