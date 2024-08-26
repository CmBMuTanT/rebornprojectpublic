-- <|> Hello, fucker | Taxin2012 and PURP was here | Mysterious Zone Project | mzrp.ru <|>
local a = PLUGIN
ix.anim.stalker_animations = {
    normal = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {{"idle_0_idle_3"}, "idle_0_idle_3"},
            damage_seq = {"dmg_norm_torso_0_idle_0", "dmg_norm_torso_0_idle_0"},
            bandit_seq = {{"bandit_idle_0_idle_1"}, "norm_torso_0_aim_0"},
            military_seq = {{"soldier_idle_0_idle_1"}, "norm_torso_0_aim_0"},
            zombified_seq = {{"zombified_idle_0_idle_1"}, "zombified_norm_torso_0_idle_1"}
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {{"cr_idle_0_0", "cr_idle_0_1", "cr_idle_0_2"}, "cr_torso_0_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_5_walk", "norm_torso_0_aim_2"},
            bandit_seq = {"bandit_norm_torso_0_walk", "norm_torso_0_aim_2"},
            damage_seq = {"dmg_norm_torso_0_walk_0", "dmg_norm_torso_0_walk_0"},
            zombified_seq = {"zombified_norm_torso_0_walk", "zombified_norm_torso_0_walk"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_0_aim_2_1", "cr_torso_0_aim_2"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_1_run_1", "norm_torso_0_aim_3"},
            damage_seq = {"dmg_norm_torso_0_run_0", "dmg_norm_torso_0_run_0"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = "wick_gesture_cr_torso_5_attack_0",
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = "wick_gesture_norm_torso_5_attack_0",
                reload = nil,
                cr_reload = nil
            },
            damage_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = nil,
                reload = nil,
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = nil,
                reload = nil,
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_0_idle_1", "wick_jump_norm_torso_0_aim_0"},
            damage_seq = {"wick_jump_dmg_norm_torso_0_idle_1", "wick_jump_dmg_norm_torso_0_idle_1"},
            zombified_seq = {"wick_jump_zombified_idle_0_idle_0", "wick_jump_zombified_idle_0_idle_0"}
        }
    },
    pistol = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"idle_1_idle_0", "idle_1_idle_1", "idle_1_idle_2", "idle_1_idle_3", "idle_1_idle_4"},
                "norm_torso_1_aim_1",
                "norm_torso_1_aim_0"
            },
            damage_seq = {"dmg_norm_torso_1_idle_1", "dmg_norm_torso_1_aim_2", "dmg_norm_torso_1_aim_0"},
            bandit_seq = {
                {
                    "bandit_idle_1_idle_0",
                    "bandit_idle_1_idle_1",
                    "bandit_idle_1_idle_2",
                    "bandit_idle_1_idle_3",
                    "bandit_idle_1_idle_4"
                },
                "norm_torso_1_aim_1",
                "norm_torso_1_aim_0"
            },
            military_seq = {
                {
                    "soldier_idle_1_idle_0",
                    "soldier_idle_1_idle_1",
                    "soldier_idle_1_idle_2",
                    "soldier_idle_1_idle_3",
                    "soldier_idle_1_idle_4"
                },
                "norm_torso_1_aim_1",
                "norm_torso_1_aim_0"
            },
            zombified_seq = {
                {
                    "zombified_idle_1_idle_0",
                    "zombified_idle_1_idle_1",
                    "zombified_idle_1_idle_2",
                    "zombified_idle_1_idle_3",
                    "zombified_idle_1_idle_4"
                },
                "zombified_norm_torso_1_aim_1"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {{"cr_idle_1_0", "cr_idle_1_1", "cr_idle_1_2"}, "cr_torso_1_aim_1", "cr_torso_1_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_1_walk", "norm_torso_1_aim_2", "norm_torso_1_aim_2_1"},
            damage_seq = {"dmg_norm_torso_1_walk_0", "dmg_norm_torso_1_walk_0", "norm_torso_1_aim_2_1"},
            bandit_seq = {"bandit_norm_torso_1_walk", "norm_torso_1_aim_2", "norm_torso_1_aim_2_1"},
            zombified_seq = {"zombified_norm_torso_1_walk", "zombified_norm_torso_1_aim_2", "norm_torso_1_aim_2_1"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_1_aim_2_2", "cr_torso_1_aim_2", "cr_torso_1_aim_2_1"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_1_run_1", "norm_torso_1_aim_3"},
            damage_seq = {"dmg_norm_torso_1_run_0", "dmg_norm_torso_1_run_0"},
            zombified_seq = {"dmg_norm_torso_1_run_0", "dmg_norm_torso_1_run_0"}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_1_attack_1",
                cr_attack = "wick_gesture_cr_torso_1_attack_1",
                aim_attack = "wick_gesture_norm_torso_1_attack_0",
                cr_aim_attack = "wick_gesture_cr_torso_1_attack_0",
                walk_attack = "wick_gesture_norm_torso_1_attack_3",
                cr_walk_attack = "wick_gesture_cr_torso_1_attack_3",
                run_attack = "wick_gesture_norm_torso_1_attack_2",
                reload = "wick_gesture_norm_torso_1_reload_0",
                cr_reload = "wick_gesture_cr_torso_1_reload_0"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_1_attack_1",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_1_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_1_reload_0",
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_1_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_1_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_1_reload_0",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_1_idle_1", "wick_jump_norm_torso_1_aim_1", "wick_jump_norm_torso_1_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_1_idle_1",
                "wick_jump_dmg_norm_torso_1_aim_0",
                "wick_jump_dmg_norm_torso_1_aim_2"
            },
            zombified_seq = {"wick_jump_zombified_idle_1_idle_0", "wick_jump_zombified_norm_torso_1_aim_1"}
        }
    },
    ar2 = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"idle_2_idle_1", "idle_2_idle_1", "idle_2_idle_2", "idle_2_idle_3", "idle_2_idle_4"},
                "norm_torso_2_aim_1",
                "norm_torso_2_aim_0"
            },
            damage_seq = {"dmg_norm_torso_2_idle_1", "dmg_norm_torso_2_aim_2", "dmg_norm_torso_2_aim_0"},
            fat_seq = {
                {
                    "fat_idle_2_idle_1",
                    "fat_idle_2_idle_1",
                    "fat_idle_2_idle_2",
                    "fat_idle_2_idle_3",
                    "fat_idle_2_idle_4"
                },
                "norm_torso_2_aim_1",
                "norm_torso_2_aim_0"
            },
            bandit_seq = {
                {
                    "bandit_idle_2_idle_0",
                    "bandit_idle_2_idle_1",
                    "bandit_idle_2_idle_2",
                    "bandit_idle_2_idle_3",
                    "bandit_idle_2_idle_4"
                },
                "norm_torso_2_aim_1",
                "norm_torso_2_aim_0"
            },
            military_seq = {  
                {
                    "soldier_idle_9_idle_0",
                    "soldier_idle_2_idle_1",
                    "soldier_idle_2_idle_2",
                    "soldier_idle_2_idle_3",
                    "soldier_idle_2_idle_4"
                },
                "norm_torso_2_aim_1",
                "norm_torso_2_aim_0"
            },
            zombified_seq = {
                {
                    "zombified_idle_2_idle_0",
                    "zombified_idle_2_idle_1",
                    "zombified_idle_2_idle_2",
                    "zombified_idle_2_idle_3",
                    "zombified_idle_2_idle_4"
                },
                "zombified_norm_torso_2_aim_1",
                "norm_torso_2_aim_0"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {{"cr_idle_2_0", "cr_idle_2_1", "cr_idle_2_2"}, "cr_torso_2_aim_1", "cr_torso_2_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_2_walk", "norm_torso_2_aim_2", "norm_torso_2_aim_2_1"},
            damage_seq = {"dmg_norm_torso_2_walk_0", "dmg_norm_torso_2_walk_0", "norm_torso_2_aim_2_1"},
            bandit_seq = {"bandit_norm_torso_2_walk", "norm_torso_2_aim_2", "norm_torso_2_aim_2_1"},
            zombified_seq = {"zombified_norm_torso_2_walk", "zombified_norm_torso_2_aim_2", "norm_torso_2_aim_2_1"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_2_aim_2_2", "cr_torso_2_aim_2", "cr_torso_2_aim_2_1"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_2_run_1", "norm_torso_2_aim_3"},
            damage_seq = {"dmg_norm_torso_2_run_0", "dmg_norm_torso_2_run_0"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_2_attack_1",
                cr_attack = "wick_gesture_cr_torso_2_attack_1",
                aim_attack = "wick_gesture_norm_torso_2_attack_0",
                cr_aim_attack = "wick_gesture_cr_torso_2_attack_0",
                walk_attack = "wick_gesture_norm_torso_2_attack_3",
                cr_walk_attack = "wick_gesture_cr_torso_2_attack_3",
                run_attack = "wick_gesture_norm_torso_2_attack_2",
                reload = "wick_gesture_norm_torso_2_reload_0",
                cr_reload = "wick_gesture_cr_torso_2_reload_0"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_2_attack_0",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_2_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_2_reload_0",
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_2_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_2_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_2_reload_0",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_2_idle_1", "wick_jump_norm_torso_2_aim_1", "wick_jump_norm_torso_2_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_2_idle_1",
                "wick_jump_dmg_norm_torso_2_aim_0",
                "wick_jump_dmg_norm_torso_2_aim_2"
            },
            zombified_seq = {
                "wick_jump_zombified_idle_1_idle_0",
                "wick_jump_zombified_norm_torso_2_aim_1",
                "wick_jump_norm_torso_2_aim_0"
            }
        }
    },
    crossbow = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"idle_3_idle_0", "idle_3_idle_1", "idle_3_idle_2", "idle_3_idle_3", "idle_3_idle_4"},
                "norm_torso_3_aim_1",
                "norm_torso_3_aim_0"
            },
            damage_seq = {"dmg_norm_torso_3_idle_1", "dmg_norm_torso_3_aim_2", "dmg_norm_torso_3_aim_0"},
            fat = {
                {
                    "fat_idle_3_idle_0",
                    "fat_idle_3_idle_1",
                    "fat_idle_3_idle_2",
                    "fat_idle_3_idle_3",
                    "fat_idle_3_idle_4"
                },
                "norm_torso_3_aim_1",
                "norm_torso_3_aim_0"
            },
            bandit_seq = {
                {
                    "bandit_idle_3_idle_0",
                    "bandit_idle_3_idle_1",
                    "bandit_idle_3_idle_2",
                    "bandit_idle_3_idle_3",
                    "bandit_idle_3_idle_4"
                },
                "norm_torso_3_aim_1",
                "norm_torso_3_aim_0"
            },
            bandit_seq = {
                {
                    "soldier_idle_3_idle_0",
                    "soldier_idle_3_idle_1",
                    "soldier_idle_3_idle_2",
                    "soldier_idle_3_idle_3",
                    "soldier_idle_3_idle_4"
                },
                "norm_torso_3_aim_1",
                "norm_torso_3_aim_0"
            },
            zombified_seq = {
                {
                    "zombified_idle_3_idle_0",
                    "zombified_idle_3_idle_1",
                    "zombified_idle_3_idle_2",
                    "zombified_idle_3_idle_3",
                    "zombified_idle_3_idle_4"
                },
                "zombified_norm_torso_3_aim_1",
                "norm_torso_3_aim_0"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {
                {"cr_idle_3_0", "cr_idle_3_1", "cr_idle_3_2", "cr_idle_3_3", "cr_idle_3_4"},
                "cr_torso_3_aim_1",
                "cr_torso_3_aim_0"
            },
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_3_walk", "norm_torso_3_aim_2", "norm_torso_3_aim_2_1"},
            damage_seq = {"dmg_norm_torso_3_walk_0", "dmg_norm_torso_3_walk_0", "norm_torso_3_aim_2_1"},
            bandit_seq = {"bandit_norm_torso_3_walk", "norm_torso_3_aim_2", "norm_torso_3_aim_2_1"},
            zombified_seq = {"zombified_norm_torso_3_walk", "zombified_norm_torso_3_aim_2", "norm_torso_3_aim_2_1"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_3_aim_2_2", "cr_torso_3_aim_2", "cr_torso_3_aim_2_1"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_3_run_1", "norm_torso_3_aim_3"},
            damage_seq = {"dmg_norm_torso_3_run_0", "dmg_norm_torso_3_run_0"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_3_attack_1",
                cr_attack = "wick_gesture_cr_torso_3_attack_1",
                aim_attack = "wick_gesture_norm_torso_3_attack_0",
                cr_aim_attack = "wick_gesture_cr_torso_3_attack_0",
                walk_attack = "wick_gesture_norm_torso_3_attack_3",
                cr_walk_attack = "wick_gesture_cr_torso_3_attack_3",
                run_attack = "wick_gesture_norm_torso_3_attack_2",
                reload = "wick_gesture_norm_torso_3_reload_0",
                cr_reload = "wick_gesture_cr_torso_3_reload_0"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_3_attack_1",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_3_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_3_reload_0",
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_3_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_3_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_3_reload_0",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_3_idle_1", "wick_jump_norm_torso_3_aim_1", "wick_jump_norm_torso_3_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_3_idle_1",
                "wick_jump_dmg_norm_torso_3_aim_0",
                "wick_jump_dmg_norm_torso_3_aim_2"
            },
            zombified_seq = {"wick_jump_zombified_idle_3_idle_0", "wick_jump_zombified_norm_torso_3_aim_1"}
        }
    },
    smg = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"soldier_idle_9_idle_0", "idle_8_idle_1", "idle_8_idle_2", "idle_8_idle_3", "idle_8_idle_4"},
                "norm_torso_8_aim_1",
                "norm_torso_8_aim_0"
            },
            damage_seq = {"dmg_norm_torso_8_idle_1", "dmg_norm_torso_8_aim_2", "dmg_norm_torso_8_aim_0"},
            fat = {
                {
                    "soldier_idle_9_idle_0",
                    "fat_idle_8_idle_1",
                    "fat_idle_8_idle_2",
                    "fat_idle_8_idle_3",
                    "fat_idle_8_idle_4"
                },
                "norm_torso_8_aim_1",
                "norm_torso_8_aim_0"
            },
            bandit_seq = {
                {
                    "bandit_idle_8_idle_0",
                    "bandit_idle_8_idle_1",
                    "bandit_idle_8_idle_2",
                    "bandit_idle_8_idle_3",
                    "bandit_idle_8_idle_4"
                },
                "norm_torso_8_aim_1",
                "norm_torso_8_aim_0"
            },
            zombified_seq = {
                {
                    "zombified_idle_8_idle_0",
                    "zombified_idle_8_idle_1",
                    "zombified_idle_8_idle_2",
                    "zombified_idle_8_idle_3",
                    "zombified_idle_8_idle_4"
                },
                "zombified_norm_torso_8_aim_1",
                "norm_torso_8_aim_0"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {{"cr_idle_8_0", "cr_idle_8_1", "cr_idle_8_2"}, "cr_torso_8_aim_1", "cr_torso_8_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_8_walk", "norm_torso_8_aim_2", "norm_torso_8_aim_2_1"},
            damage_seq = {"dmg_norm_torso_8_walk_0", "dmg_norm_torso_8_walk_0", "norm_torso_8_aim_2_1"},
            bandit_seq = {"bandit_norm_torso_8_walk", "norm_torso_8_aim_2", "norm_torso_8_aim_2_1"},
            zombified_seq = {"zombified_norm_torso_8_walk", "zombified_norm_torso_8_aim_2", "norm_torso_8_aim_2_1"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_8_aim_2_2", "cr_torso_8_aim_2", "cr_torso_8_aim_2_1"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_8_run_1", "norm_torso_8_aim_3"},
            damage_seq = {"dmg_norm_torso_8_run_0", "dmg_norm_torso_8_run_0"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_8_attack_1",
                cr_attack = "wick_gesture_cr_torso_8_attack_1",
                aim_attack = "wick_gesture_norm_torso_8_attack_0",
                cr_aim_attack = "wick_gesture_cr_torso_8_attack_0",
                walk_attack = "wick_gesture_norm_torso_8_attack_3",
                cr_walk_attack = "wick_gesture_cr_torso_8_attack_3",
                run_attack = "wick_gesture_norm_torso_8_attack_2",
                reload = "wick_gesture_norm_torso_8_reload_0",
                cr_reload = "wick_gesture_cr_torso_8_reload_0"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_8_attack_1",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_8_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_8_reload_0",
                cr_reload = nil,
                cr_drop = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_8_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_8_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_8_reload_0",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_8_idle_1", "wick_jump_norm_torso_8_aim_1", "wick_jump_norm_torso_8_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_2_idle_1",
                "wick_jump_dmg_norm_torso_2_aim_0",
                "wick_jump_dmg_norm_torso_2_aim_2"
            },
            zombified_seq = {
                "wick_jump_zombified_idle_8_idle_0",
                "wick_jump_zombified_norm_torso_8_aim_1",
                "wick_jump_dmg_norm_torso_2_aim_2"
            }
        }
    },
    shotgun = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"soldier_idle_9_idle_0", "idle_9_idle_1", "idle_9_idle_2", "idle_9_idle_3", "idle_9_idle_4"},
                "norm_torso_9_aim_1",
                "norm_torso_9_aim_0"
            },
            damage_seq = {"dmg_norm_torso_9_idle_1", "dmg_norm_torso_9_aim_2", "dmg_norm_torso_9_aim_0"},
            fat = {
                {
                    "soldier_idle_9_idle_0",
                    "fat_idle_9_idle_1",
                    "fat_idle_9_idle_2",
                    "fat_idle_9_idle_3",
                    "fat_idle_9_idle_4"
                },
                "norm_torso_9_aim_1",
                "norm_torso_9_aim_0"
            },
            bandit_seq = {
                {
                    "bandit_idle_9_idle_0",
                    "bandit_idle_9_idle_1",
                    "bandit_idle_9_idle_2",
                    "bandit_idle_9_idle_3",
                    "bandit_idle_9_idle_4"
                },
                "norm_torso_9_aim_1",
                "norm_torso_9_aim_0"
            },
            military_seq = {
                {
                    "idle_2_idle_1",
                    "soldier_idle_9_idle_1",
                    "soldier_idle_9_idle_2",
                    "soldier_idle_9_idle_3",
                    "soldier_idle_9_idle_4"
                },
                "norm_torso_9_aim_1",
                "norm_torso_9_aim_0"
            },
            zombified_seq = {
                {
                    "zombified_idle_9_idle_0",
                    "zombified_idle_9_idle_1",
                    "zombified_idle_9_idle_2",
                    "zombified_idle_9_idle_3",
                    "zombified_idle_9_idle_4"
                },
                "norm_torso_9_aim_1",
                "norm_torso_9_aim_0"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {{"cr_idle_9_0", "cr_idle_9_1", "cr_idle_9_2"}, "cr_torso_9_aim_1", "cr_torso_9_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_9_walk", "norm_torso_9_aim_2", "norm_torso_9_aim_2_1"},
            damage_seq = {"dmg_norm_torso_9_walk_0", "dmg_norm_torso_9_walk_0", "norm_torso_9_aim_2_1"},
            bandit_seq = {"bandit_norm_torso_9_walk", "norm_torso_9_walk0_0", "norm_torso_9_aim_2_1"},
            zombified_seq = {"zombified_norm_torso_9_walk", "zombified_norm_torso_9_aim_2", "norm_torso_9_aim_2_1"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_9_aim_2_2", "cr_torso_9_aim_2", "cr_torso_9_aim_2_1"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_9_run_1", "norm_torso_9_aim_3"},
            damage_seq = {"dmg_norm_torso_9_run_0", "dmg_norm_torso_9_run_0"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_9_attack_1",
                cr_attack = "wick_gesture_cr_torso_9_attack_1",
                aim_attack = "wick_gesture_norm_torso_9_attack_0",
                cr_aim_attack = "wick_gesture_cr_torso_9_attack_0",
                walk_attack = "wick_gesture_norm_torso_9_attack_3",
                cr_walk_attack = "wick_gesture_cr_torso_9_attack_3",
                run_attack = "wick_gesture_norm_torso_9_attack_2",
                reload = "wick_gesture_norm_torso_9_reload_3",
                cr_reload = "wick_gesture_cr_torso_9_reload_3"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_9_attack_1",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_9_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_9_reload_3",
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_9_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_9_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_9_reload_3",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_9_idle_1", "wick_jump_norm_torso_9_aim_1", "wick_jump_norm_torso_9_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_9_idle_1",
                "wick_jump_dmg_norm_torso_9_aim_0",
                "wick_jump_dmg_norm_torso_9_aim_2"
            },
            zombified_seq = {
                "wick_jump_zombified_idle_9_idle_0",
                "wick_jump_zombified_norm_torso_9_aim_1",
                "wick_jump_dmg_norm_torso_9_aim_2"
            }
        }
    },
    duel = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"idle_10_idle_0", "idle_10_idle_1", "idle_10_idle_2", "idle_10_idle_3", "idle_10_idle_4"},
                "norm_torso_10_aim_1",
                "norm_torso_10_aim_0"
            },
            damage_seq = {"dmg_norm_torso_10_idle_1", "dmg_norm_torso_10_aim_2", "dmg_norm_torso_10_aim_0"},
            fat = {
                {
                    "fat_idle_10_idle_0",
                    "fat_idle_10_idle_1",
                    "fat_idle_10_idle_2",
                    "fat_idle_10_idle_3",
                    "fat_idle_10_idle_4"
                },
                "norm_torso_10_aim_1",
                "norm_torso_10_aim_0"
            },
            bandit_seq = {
                {
                    "bandit_idle_10_idle_0",
                    "bandit_idle_10_idle_1",
                    "bandit_idle_10_idle_2",
                    "bandit_idle_10_idle_3",
                    "bandit_idle_10_idle_4"
                },
                "norm_torso_10_aim_1",
                "norm_torso_10_aim_0"
            },
            bandit_seq = {
                {
                    "soldier_idle_10_idle_0",
                    "soldier_idle_10_idle_1",
                    "soldier_idle_10_idle_2",
                    "soldier_idle_10_idle_3",
                    "soldier_idle_10_idle_4"
                },
                "norm_torso_10_aim_1",
                "norm_torso_10_aim_0"
            },
            zombified_seq = {
                {
                    "zombified_idle_10_idle_0",
                    "zombified_idle_10_idle_1",
                    "zombified_idle_10_idle_2",
                    "zombified_idle_10_idle_3",
                    "zombified_idle_10_idle_4"
                },
                "norm_torso_10_aim_1",
                "norm_torso_10_aim_0"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {
                {"cr_idle_10_0", "cr_idle_10_1", "cr_idle_10_2", "cr_idle_10_3", "cr_idle_10_4"},
                "cr_torso_10_aim_1",
                "cr_torso_10_aim_0"
            },
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_10_walk", "norm_torso_10_aim_2", "norm_torso_10_aim_2_1"},
            damage_seq = {"dmg_norm_torso_10_walk_0", "dmg_norm_torso_10_walk_0", "norm_torso_10_aim_2_1"},
            bandit_seq = {"bandit_norm_torso_10_walk", "norm_torso_10_aim_2", "norm_torso_10_aim_2_1"},
            zombified_seq = {"zombified_norm_torso_10_walk", "zombified_norm_torso_10_aim_2", "norm_torso_10_aim_2_1"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_10_aim_2_2", "cr_torso_10_aim_2", "cr_torso_10_aim_2_1"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_10_run_1", "norm_torso_10_aim_3"},
            damage_seq = {"dmg_norm_torso_10_run_0", "dmg_norm_torso_10_run_0"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_10_attack_1",
                cr_attack = "wick_gesture_cr_torso_10_attack_1",
                aim_attack = "wick_gesture_norm_torso_10_attack_0",
                cr_aim_attack = "wick_gesture_cr_torso_10_attack_0",
                walk_attack = "wick_gesture_norm_torso_10_attack_3",
                cr_walk_attack = "wick_gesture_cr_torso_10_attack_3",
                run_attack = "wick_gesture_norm_torso_10_attack_2",
                reload = "wick_gesture_norm_torso_10_reload_3",
                cr_reload = "wick_gesture_cr_torso_10_reload_3"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_10_attack_1",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_10_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_10_reload_3",
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_10_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_10_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_10_reload_3",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {
                "wick_jump_norm_torso_10_idle_1",
                "wick_jump_norm_torso_10_aim_1",
                "wick_jump_norm_torso_10_aim_0"
            },
            damage_seq = {
                "wick_jump_dmg_norm_torso_10_idle_1",
                "wick_jump_dmg_norm_torso_10_aim_0",
                "wick_jump_dmg_norm_torso_10_aim_2"
            },
            zombified_seq = {"wick_jump_zombified_idle_10_idle_0", "wick_jump_zombified_norm_torso_10_aim_1"}
        }
    },
    camera = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {
                {"idle_1_idle_0", "idle_1_idle_1", "idle_1_idle_2", "idle_1_idle_3", "idle_1_idle_4"},
                "norm_torso_7_aim_0",
                "norm_torso_7_attack_1"
            },
            damage_seq = {"dmg_norm_torso_7_idle_1", "dmg_norm_torso_7_idle_1"},
            zombified_seq = {
                {
                    "zombified_idle_1_idle_0",
                    "zombified_idle_1_idle_1",
                    "zombified_idle_1_idle_2",
                    "zombified_idle_1_idle_3",
                    "zombified_idle_1_idle_4"
                },
                "zombified_norm_torso_1_aim_1"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {"cr_torso_7_aim_0", "cr_torso_7_aim_0", "cr_torso_7_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_5_walk", "norm_torso_7_aim_2", "norm_torso_7_aim_2"},
            damage_seq = {"dmg_norm_torso_7_walk_0", "dmg_norm_torso_7_walk_0", "norm_torso_7_aim_2"},
            zombified_seq = {"zombified_norm_torso_1_walk", "zombified_norm_torso_1_aim_2", "norm_torso_7_aim_2"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_7_aim_2", "cr_torso_7_aim_2", "cr_torso_7_aim_2"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_5_run_1", "norm_torso_7_aim_3", "norm_torso_7_aim_3"},
            damage_seq = {"dmg_norm_torso_1_run_0", "dmg_norm_torso_1_run_0", "norm_torso_7_aim_3"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_7_attack_2",
                cr_attack = "wick_gesture_cr_torso_7_attack_2",
                walk_attack = "wick_gesture_norm_torso_7_attack_2",
                cr_walk_attack = "wick_gesture_cr_torso_7_attack_2"
            },
            damage_seq = {
                attack = "wick_gesture_dmg_norm_torso_1_attack_1",
                cr_attack = nil,
                aim_attack = "wick_gesture_dmg_norm_torso_1_attack_0",
                cr_aim_attack = nil,
                walk_attack = nil,
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_dmg_norm_torso_1_reload_0",
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_zombified_norm_torso_1_attack_1",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_zombified_norm_torso_1_attack_1",
                cr_walk_attack = nil,
                run_attack = nil,
                reload = "wick_gesture_zombified_norm_torso_1_reload_0",
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_1_idle_1", "wick_jump_norm_torso_5_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_1_idle_1",
                "wick_jump_dmg_norm_torso_1_aim_0",
                "wick_jump_dmg_norm_torso_1_aim_2"
            },
            zombified_seq = {"wick_jump_zombified_idle_1_idle_0", "wick_jump_zombified_norm_torso_1_aim_1"}
        }
    },
    melee = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {{"norm_torso_0_idle_1"}, "norm_torso_5_aim_0"},
            damage_seq = {"dmg_norm_torso_0_idle_1", "dmg_norm_torso_0_idle_1"},
            zombified_seq = {
                {
                    "zombified_idle_0_idle_0",
                    "zombified_idle_0_idle_1",
                    "zombified_idle_0_idle_2",
                    "zombified_idle_0_idle_3",
                    "zombified_idle_0_idle_4"
                },
                {
                    "zombified_idle_0_idle_0",
                    "zombified_idle_0_idle_1",
                    "zombified_idle_0_idle_2",
                    "zombified_idle_0_idle_3",
                    "zombified_idle_0_idle_4"
                }
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {"cr_torso_5_aim_0", "cr_torso_5_aim_0", "cr_torso_5_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_5_walk", "norm_torso_5_aim_2", "norm_torso_5_aim_2"},
            damage_seq = {"dmg_norm_torso_0_walk_0", "dmg_norm_torso_0_walk_0", "norm_torso_5_aim_2"},
            zombified_seq = {"zombified_norm_torso_0_walk", "zombified_norm_torso_0_walk", "norm_torso_5_aim_2"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_7_aim_2", "cr_torso_7_aim_2", "cr_torso_7_aim_2"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_5_run_1", "norm_torso_5_aim_3", "norm_torso_5_aim_3"},
            damage_seq = {"dmg_norm_torso_0_run_0", "dmg_norm_torso_0_run_0", "norm_torso_5_aim_3"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = "wick_gesture_cr_torso_5_attack_0",
                reload = "wick_gesture_norm_torso_5_attack_1",
                cr_reload = "wick_gesture_cr_torso_5_attack_1",
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = "wick_gesture_norm_torso_5_attack_0"
            },
            damage_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = "wick_gesture_cr_torso_5_attack_0",
                reload = "wick_gesture_norm_torso_5_attack_1",
                cr_reload = "wick_gesture_cr_torso_5_attack_1"
            },
            zombified_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = "wick_gesture_cr_torso_5_attack_0",
                reload = "wick_gesture_norm_torso_5_attack_1",
                cr_reload = "wick_gesture_cr_torso_5_attack_1"
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_1_idle_1", "wick_jump_norm_torso_5_aim_0"},
            damage_seq = {
                "wick_jump_dmg_norm_torso_1_idle_1",
                "wick_jump_dmg_norm_torso_1_aim_0",
                "wick_jump_dmg_norm_torso_1_aim_2"
            },
            zombified_seq = {"wick_jump_zombified_idle_1_idle_0", "wick_jump_zombified_norm_torso_1_aim_1"}
        }
    },
    slam = {
        [ACT_MP_STAND_IDLE] = {
            base_seq = {"binoculars_idle_0", "binoculars_idle_0", "binoculars_zoom_idle_3"},
            damage_seq = {"binoculars_idle_0", "binoculars_idle_0", "binoculars_zoom_idle_3"},
            zombified_seq = {
                {
                    "zombified_idle_0_idle_0",
                    "zombified_idle_0_idle_1",
                    "zombified_idle_0_idle_2",
                    "zombified_idle_0_idle_3",
                    "zombified_idle_0_idle_4"
                },
                "zombified_norm_torso_0_idle_1"
            }
        },
        [ACT_MP_CROUCH_IDLE] = {
            base_seq = {{"cr_idle_0_0", "cr_idle_0_1", "cr_idle_0_2"}, "cr_torso_0_aim_0"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_WALK] = {
            base_seq = {"norm_torso_1_walk", "norm_torso_1_walk"},
            damage_seq = {"norm_torso_1_walk", "norm_torso_1_walk"},
            zombified_seq = {"zombified_norm_torso_0_walk", "zombified_norm_torso_0_walk"}
        },
        [ACT_MP_CROUCHWALK] = {
            base_seq = {"cr_torso_0_aim_2_1", "cr_torso_0_aim_2"},
            damage_seq = {},
            zombified_seq = {}
        },
        [ACT_MP_RUN] = {
            base_seq = {"norm_torso_1_run_1", "norm_torso_1_run_1"},
            damage_seq = {"norm_torso_1_run_1", "norm_torso_1_run_1"},
            zombified_seq = {}
        },
        ["gesture_animations"] = {
            base_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = "wick_gesture_cr_torso_5_attack_0",
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = "wick_gesture_norm_torso_5_attack_0",
                reload = nil,
                cr_reload = nil
            },
            damage_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = nil,
                reload = nil,
                cr_reload = nil
            },
            zombified_seq = {
                attack = "wick_gesture_norm_torso_5_attack_0",
                cr_attack = nil,
                aim_attack = nil,
                cr_aim_attack = nil,
                walk_attack = "wick_gesture_norm_torso_5_attack_0",
                cr_walk_attack = "wick_gesture_cr_torso_5_attack_0",
                run_attack = nil,
                reload = nil,
                cr_reload = nil
            }
        },
        ["glide"] = {
            base_seq = {"wick_jump_norm_torso_0_idle_1", "wick_jump_norm_torso_0_aim_0"},
            damage_seq = {"wick_jump_dmg_norm_torso_0_idle_1", "wick_jump_dmg_norm_torso_0_idle_1"},
            zombified_seq = {"wick_jump_zombified_idle_0_idle_0", "wick_jump_zombified_idle_0_idle_0"}
        }
    },
    magic = {
        [ACT_MP_STAND_IDLE] = {base_seq = {"norm_torso_pda_idle_1", "norm_torso_pda_idle_1", "norm_torso_pda_idle_1"}},
        [ACT_MP_CROUCH_IDLE] = {base_seq = {"cr_torso_pda_aim_0", "cr_torso_pda_aim_0", "cr_torso_pda_aim_0"}},
        [ACT_MP_WALK] = {base_seq = {"norm_torso_pda_walk", "norm_torso_pda_walk", "norm_torso_pda_walk"}},
        [ACT_MP_CROUCHWALK] = {base_seq = {"cr_torso_pda_aim_2", "cr_torso_pda_aim_2", "cr_torso_pda_aim_2"}},
        [ACT_MP_RUN] = {base_seq = {"norm_torso_pda_run_1", "norm_torso_pda_run_1", "norm_torso_pda_run_1"}},
        ["gesture_animations"] = {},
        ["glide"] = {base_seq = {"wick_jump_norm_torso_pda_idle_1", "wick_jump_norm_torso_pda_idle_1"}}
    }
}
local function b(d, e)
    e = e or d:GetActiveWeapon()
    local f = "normal"
    if (IsValid(e)) then
        f = e.HoldType or e:GetHoldType()
        f = HOLDTYPE_TRANSLATOR[f] or f
    end
    d.ixAnimHoldType = f
end
local function c(d, e)
    local f = ix.anim[d.ixAnimModelClass] or {}
    if IsValid(e) then
        local g = e:IsChair() and "chair" or e:GetClass()
        if (f.vehicle and f.vehicle[g]) then
            d.ixAnimTable = f.vehicle[g]
        else
            d.ixAnimTable = f.normal[ACT_MP_CROUCH_IDLE]
        end
    else
        d.ixAnimTable = f[d.ixAnimHoldType]
    end
    d.ixAnimGlide = f["glide"]
end
hook.Add(
    "PlayerWeaponChanged",
    a.uniqueID .. "PlayerWeaponChanged",
    function(d, e)
        timer.Simple(
            0,
            function()
                if IsValid(d) then
                    b(d, e)
                    c(d)
                end
            end
        )
    end
)
