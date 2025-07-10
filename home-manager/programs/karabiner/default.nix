_: {
  # Karabiner-Elements設定
  xdg.configFile."karabiner/karabiner.json".text = builtins.toJSON {
    profiles = [
      {
        complex_modifications = {
          rules = [
            {
              description = "シフトキーを単体で押したときに、英数・かなキーを送信する。（左シフトキーは英数、右シフトキーはかな)";
              manipulators = [
                {
                  from = {
                    key_code = "left_shift";
                    modifiers = {
                      optional = [ "any" ];
                    };
                  };
                  parameters = {
                    "basic.to_if_held_down_threshold_milliseconds" = 100;
                  };
                  to = [
                    {
                      key_code = "left_shift";
                      lazy = true;
                    }
                  ];
                  to_if_alone = [ { key_code = "japanese_eisuu"; } ];
                  to_if_held_down = [ { key_code = "left_shift"; } ];
                  type = "basic";
                }
                {
                  from = {
                    key_code = "right_shift";
                    modifiers = {
                      optional = [ "any" ];
                    };
                  };
                  parameters = {
                    "basic.to_if_held_down_threshold_milliseconds" = 100;
                  };
                  to = [
                    {
                      key_code = "right_shift";
                      lazy = true;
                    }
                  ];
                  to_if_alone = [ { key_code = "japanese_kana"; } ];
                  to_if_held_down = [ { key_code = "right_shift"; } ];
                  type = "basic";
                }
              ];
            }
          ];
        };
        name = "Default profile";
        selected = true;
        virtual_hid_keyboard = {
          keyboard_type_v2 = "ansi";
        };
      }
    ];
  };
}
