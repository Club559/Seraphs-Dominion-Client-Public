package _nA_ {
import flash.display.Sprite;

public class _eX_1_ {

    private static const width_:Number = 89;
    public static const height_:Number = 25;
    public static const _str4284:uint = 28;

    public static function _c9_9():Sprite{
        var _local1:Number = width_;
        var _local2:Number = height_;
        return (_k1_(_local1, _local2));
    }
    public static function _k1_(_arg1:Number, _arg2:Number):Sprite{
        var _local3:Sprite = new Sprite();
        return (draw(_local3, _arg1, _arg2));
    }
    private static function draw(_arg1:Sprite, _arg2:Number, _arg3:Number):Sprite{
        _arg1.graphics.beginFill(0, 0.4);
        _arg1.graphics.drawRoundRect(0, 0, _arg2, _arg3, 12, 12);
        _arg1.graphics.endFill();
        return (_arg1);
    }
}
}
