local millennium = require("millennium")

-- Anchor to both neighbours so unrelated entries are never changed.
local store_menu = [[(\{name:"#Menu_DiscoveryQueue",urlName:"StoreExplore"[^{}]*\},)(\{name:"#Menu_Wishlist",urlName:"UserWishlist"\})]]

return {
    on_load = function()
        millennium.ready()
    end,
    patches = {
        {
            file = [[chunk~[0-9a-f]+\.js]],
            find = store_menu,
            transforms = {
                {
                    match = store_menu,
                    -- No urlName: Steam's resolver returns undefined, keeping
                    -- the native menu's onClick handler in control of navigation.
                    replace = [[\1{name:"#SaleSectionCalendar_Upcoming",onClick:()=>window.MainWindowBrowserManager.ShowURL(window.urlStore.GetStoreURL()+"personalcalendar/")},\2]],
                },
            },
        },
    },
}
