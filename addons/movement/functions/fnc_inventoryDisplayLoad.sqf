#include "..\script_component.hpp"
/*
 * Author: commy2
 * Executed every time an inventory display is opened.
 *
 * Arguments:
 * 0: Inventory display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call ACE_movement_fnc_inventoryDisplayLoad
 *
 * Public: No
 */

params ["_display"];

// forces player name control to display irrespective of isStreamFriendlyUIEnabled
(_display displayCtrl 111) ctrlShow true;

private _fnc_update = {
    params ["_display"];
    private _control = _display displayCtrl 111;
    private _format = ["%1 - %2 %3 (%4)", "%2 %3 (%4)"] select isStreamFriendlyUIEnabled;

    _control ctrlSetText format [_format,
        [ACE_player, false, true] call EFUNC(common,getName),
        localize ELSTRING(common,Weight),
        [ACE_player] call EFUNC(common,getWeight),
        [ACE_player, true] call EFUNC(common,getWeight)
    ];
};

_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];

_display call _fnc_update;
