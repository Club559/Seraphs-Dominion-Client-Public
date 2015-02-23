﻿// Decompiled by AS3 Sorcerer 1.99
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.game.GameSprite

package com.company.assembleegameclient.game {
import _011.MapInfo;

import _9R_._B_w;

import _F_1._02a;

import _G_A_._8P_;

import _U_5._D_L_;
import _U_5._zz;

import _nA_._eX_1_;

import _nA_._xI_;

import _vf._gs;

import _qN_.Account;

import _vf._gs;

import com.company.assembleegameclient.appengine._0B_u;
import com.company.assembleegameclient.appengine._0K_R_;
import com.company.assembleegameclient.map._0D_v;
import com.company.assembleegameclient.map._X_l;
import com.company.assembleegameclient.net.Server;
import com.company.assembleegameclient.net._1f;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Projectile;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.ui.Protip;
import com.company.assembleegameclient.ui._0B_X_;
import com.company.assembleegameclient.ui._0B_v;
import com.company.assembleegameclient.ui._0G_h;
import com.company.assembleegameclient.ui._1B_v;
import com.company.assembleegameclient.ui._4D_;
import com.company.assembleegameclient.ui._L_N_;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util._x2;
import com.company.googleanalytics.GA;
import com.company.ui.SimpleText;
import com.company.util.MoreColorUtil;
import com.company.util._G_;
import com.company.util._H_U_;

import flash.display.Sprite;
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.utils.ByteArray;
import flash.utils.getTimer;

public class GameSprite extends _gI_t {

    public static const _0F_s:Number = new Date().time;
    protected static const _oj:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil._0M_l);

    public function GameSprite(_arg1:Server, _arg2:int, _arg3:Boolean, _arg4:int, _arg5:int, _arg6:ByteArray, _arg7:_0K_R_, _arg8:String) {
        this.camera_ = new _0D_v();
        this.moveRecords_ = new _uw();
        super();
        this.charList_ = _arg7;
        this.map_ = new _X_l(this);
        addChild(this.map_);
        this.gsc_ = new _1f(this, _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg8);
        this.mui_ = new _07a(this);
        this.textBox_ = new _4D_(this, 600, 600);
        addChild(this.textBox_);
        this._V_1 = new _0B_X_(this, 200, 600);
        addChild(this._V_1);
        this._0H_R_ = new _0H__();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }
    //public var camera_:_0D_v;
    //public var gsc_:_1f;
    //public var mui_:_07a;
    public var textBox_:_4D_;
    public var _V_1:_0B_X_;
    //public var tutorial_:Tutorial;
    public var charList_:_0K_R_;
    public var isNexus_:Boolean = false;
    public var _H_E_:Protip = null;
    public var _0H_R_:_0H__;
    public var updateButton_:_xI_;
    public var muleButton_:_xI_;
    public var _pg:_0G_h;
    public var _4v:_L_N_;
    public var _H_t:_0B_v;
    public var _H_T_:_1B_v;
    //public var isEditor:Boolean;
    //public var lastUpdate_:int = 0;
    //public var moveRecords_:_uw;
    private var map:_X_l;
    private var _bA_:int = 0;
    private var _qA_:int = 0;
    private var _rz:_02a;
    private var _2e:Boolean;

    public function get map_():_X_l {
        return (this.map);
    }

    public function set map_(_arg1:_X_l):void {
        this.map = _arg1;
    }

    public function _S_z(_arg1:MapInfo):void {
        this.map.setProps(_arg1.width_, _arg1.height_, _arg1.name_, _arg1.background_, _arg1.allowPlayerTeleport_, _arg1.showDisplays_, _arg1.music_);
        this._dO_(_arg1);
    }

    public function _dO_(_arg1:MapInfo):void {
        if (!this._rz) {
            this._rz = new _02a();
        }
        addChild(this._rz);
        _D_L_.getInstance().dispatch(_arg1);
    }

    override public function initialize():void {
        this.map_.initialize();
        this._V_1.initialize();
        this._H_t = new _0B_v(this);
        this._H_t.x = 594;
        this._H_t.y = 0;
        addChild(this._H_t);
        this._H_T_ = new _1B_v();
        this._H_T_.x = 594;
        this._H_T_.y = 24;
        addChild(this._H_T_);
        if (this.evalIsNotInCombatMapArea()){
            this.initExtras();
        }
        if (this.map_.showDisplays_) {
            this._pg = new _0G_h(-1, true, false);
            this._pg.x = 8;
            this._pg.y = 4;
            addChild(this._pg);
            this._4v = new _L_N_("", -1);
            this._4v.x = 64;
            this._4v.y = 6;
            addChild(this._4v);
        }
        this.isNexus_ = (this.map_.name_ == "Nexus" || this.map_.name_ == "Shop" || this.map_.name_ == "Editor");
        var _local1:_0B_u = new _0B_u(Parameters._fK_(), "/log", true, 0);
        var _local2:Account = Account._get();
        var _local3:Object = {
            "game_net_user_id": _local2.gameNetworkUserId(),
            "game_net": _local2.gameNetwork(),
            "play_platform": _local2.playPlatform()
        };
        _H_U_._t2(_local3, Account._get().credentials());
        if (!this.map_.name_ == "Kitchen" && !this.map_.name_ == "Tutorial" && Parameters.data_.watchForTutorialExit == true) {
            Parameters.data_.watchForTutorialExit = false;
            this._uG_('rotmg.Marketing.track("tutorialComplete")');
            _local3["fteStepCompleted"] = 9900;
            _local1.sendRequest("logFteStep", _local3);
        }
        if (this.map_.name_ == "Kitchen") {
            _local3["fteStepCompleted"] = 200;
            _local1.sendRequest("logFteStep", _local3);
        }
        if (this.map_.name_ == "Tutorial") {
            if (Parameters.data_.needsTutorial == true) {
                Parameters.data_.watchForTutorialExit = true;
                this._uG_('rotmg.Marketing.track("install")');
                _local3["fteStepCompleted"] = 100;
                _local1.sendRequest("logFteStep", _local3);
            }
            this._q6();
        } else {
            if (!this.map_.name_ == "Kitchen" && !this.map_.showDisplays_ && Parameters.data_.showProtips) {
                this._yH_();
            }
        }
        Parameters.save();
        this._02J_();
    }

    private function initExtras():void{
        this.initMule();
        this.initUpdate();
    }
    private function initMule():void{
        var _local3:_xI_;
        _local3 = new _xI_(false, 14, "Muledump", "MULEDUMP");
        _local3.x = 6;
        _local3.y = 34;
        if (this.muleButton_ != null) {
            removeChild(this.muleButton_);
        }
        this.muleButton_ = _local3;
        addChild(this.muleButton_);
    }
    private function initUpdate():void{
        var _local3:_xI_;
        _local3 = new _xI_();
        _local3.x = 6;
        _local3.y = 62;
        if (this.updateButton_ != null) {
            removeChild(this.updateButton_);
        }
        this.updateButton_ = _local3;
        addChild(this.updateButton_);
    }

    public function _yH_():void {
        this._0M_8();
        this._H_E_ = new Protip();
        addChild(this._H_E_);
    }

    public function _0M_8():void {
        if (((this._H_E_) && (contains(this._H_E_)))) {
            removeChild(this._H_E_);
        }
        this._H_E_ = null;
    }

    public function dispose():void {
        ((contains(this.map_)) && (removeChild(this.map_)));
        this.map_.dispose();
        removeChild(this._V_1);
        this._V_1.dispose();
        _G_.clear();
        TextureRedrawer.clearCache();
        Projectile.dispose();
    }

    public function _vw():Boolean {
        var _local1:Boolean;
        if (this.map_.name_ == "Nexus" || this.map_.name_ == "Vault" || this.map_.name_ == "Guild Hall") {
            return (true);
        }
        return (false);
    }

    private function _02J_():void {
        if (this._rz) {
            this._rz._pW_();
            this._rz = null;
        }
    }

    private function _uG_(_arg1:String):void {
        if (ExternalInterface.available == false) {
            return;
        }
        try {
            ExternalInterface.call(_arg1);
        } catch (err:Error) {
        }
    }

    private function _q6():void {
        this.tutorial_ = new Tutorial(this);
        addChild(this.tutorial_);
    }

    public function onAddedToStage(_arg1:Event):void {
        if (this._2e) {
            return;
        }
        this._2e = true;
        //GA.global().trackPageview("/gameStarted");
        this._V_1.x = 600;
        this._V_1.y = 0;
        this.gsc_.connect();
        this._0H_R_.start(this);
        this.lastUpdate_ = getTimer();
        stage.addEventListener(_B_w.MONEY_CHANGED, this._L_u);
        stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    public function onRemovedFromStage(_arg1:Event):void {
        if (!this._2e) {
            return;
        }
        this._2e = false;
        this._0H_R_.stop();
        this.gsc_._08._0F_G_();
        _zz.instance.dispatch();
        stage.removeEventListener(_B_w.MONEY_CHANGED, this._L_u);
        stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function _L_u(_arg1:Event):void {
        this.gsc_._0J_l();
    }

    override public function evalIsNotInCombatMapArea():Boolean{
        return ((map.name_ == "Nexus") || (map.name_ == "Vault") || (map.name_ == "Guild Hall") || (map.name_ == "The Shop") || (map.name_ == "Nexus Tutorial"));
    }

    private function onEnterFrame(_arg1:Event):void {
        var _local5:Number;
        var _local2:int = getTimer();
        var _local3:int = (_local2 - this.lastUpdate_);
        if (this._0H_R_.update(_local3)) {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }
        this._bA_ = (this._bA_ + _local3);
        this._qA_ = (this._qA_ + 1);
        if (this._bA_ > 300000) {
            _local5 = int(Math.round(((1000 * this._qA_) / this._bA_)));
            //GA.global().trackEvent("performance", "frameRate", this.map_.name_, _local5);
            this._qA_ = 0;
            this._bA_ = 0;
        }
        _gs.updateFade();
        this.map_.update(_local2, _local3);
        this.camera_.update(_local3);
        var _local4:Player = this.map_.player_;
        if (_local4 != null) {
            this.camera_._K_g(_local4);
            this.map_.draw(this.camera_, _local2);
            this._H_t.draw(_local4.credits_, _local4.fame_);
            this._H_T_.draw(_local4.souls_);
            this._V_1.draw();
            if (this.map_.showDisplays_) {
                this._pg.draw(_local4.numStars_);
                this._4v.draw(_local4.guildName_, _local4.guildRank_);
            }
            if (_local4.isPaused()) {
                this.map_.filters = [_oj];
                this._V_1.filters = [_oj];
                this.map_.mouseEnabled = false;
                this.map_.mouseChildren = false;
                this._V_1.mouseEnabled = false;
                this._V_1.mouseChildren = false;
            } else {
                if (this.map_.filters.length > 0) {
                    this.map_.filters = [];
                    this._V_1.filters = [];
                    this.map_.mouseEnabled = true;
                    this.map_.mouseChildren = true;
                    this._V_1.mouseEnabled = true;
                    this._V_1.mouseChildren = true;
                }
            }
            this.moveRecords_._F_5(_local2, _local4.x_, _local4.y_);
        }
        this.lastUpdate_ = _local2;
    }

}
}//package com.company.assembleegameclient.game

