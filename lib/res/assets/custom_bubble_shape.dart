import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.006089650, size.height * 0.1543291);
    path_0.cubicTo(0, size.height * 0.2002719, 0, size.height * 0.2585141, 0, size.height * 0.3750000);
    path_0.cubicTo(0, size.height * 0.4914859, 0, size.height * 0.5497281, size.width * 0.006089650,
        size.height * 0.5956703);
    path_0.cubicTo(size.width * 0.01420915, size.height * 0.6569281, size.width * 0.02978310,
        size.height * 0.7055969, size.width * 0.04938530, size.height * 0.7309703);
    path_0.cubicTo(size.width * 0.06408700, size.height * 0.7500000, size.width * 0.08272450,
        size.height * 0.7500000, size.width * 0.1200000, size.height * 0.7500000);
    path_0.lineTo(size.width * 0.4381495, size.height * 0.7500000);
    path_0.cubicTo(size.width * 0.4414375, size.height * 0.7767703, size.width * 0.4477500,
        size.height * 0.8109375, size.width * 0.4566990, size.height * 0.8593750);
    path_0.cubicTo(size.width * 0.4718855, size.height * 0.9415750, size.width * 0.4794790,
        size.height * 0.9826750, size.width * 0.4897395, size.height * 0.9943469);
    path_0.cubicTo(size.width * 0.4963670, size.height * 1.001884, size.width * 0.5036350,
        size.height * 1.001884, size.width * 0.5102600, size.height * 0.9943469);
    path_0.cubicTo(size.width * 0.5205200, size.height * 0.9826750, size.width * 0.5281150,
        size.height * 0.9415750, size.width * 0.5433000, size.height * 0.8593750);
    path_0.cubicTo(size.width * 0.5522500, size.height * 0.8109375, size.width * 0.5585650,
        size.height * 0.7767703, size.width * 0.5618500, size.height * 0.7500000);
    path_0.lineTo(size.width * 0.8800000, size.height * 0.7500000);
    path_0.cubicTo(size.width * 0.9172750, size.height * 0.7500000, size.width * 0.9359150,
        size.height * 0.7500000, size.width * 0.9506150, size.height * 0.7309703);
    path_0.cubicTo(size.width * 0.9702150, size.height * 0.7055969, size.width * 0.9857900,
        size.height * 0.6569281, size.width * 0.9939100, size.height * 0.5956703);
    path_0.cubicTo(size.width, size.height * 0.5497281, size.width, size.height * 0.4914859, size.width,
        size.height * 0.3750000);
    path_0.cubicTo(size.width, size.height * 0.2585141, size.width, size.height * 0.2002719,
        size.width * 0.9939100, size.height * 0.1543291);
    path_0.cubicTo(size.width * 0.9857900, size.height * 0.09307219, size.width * 0.9702150,
        size.height * 0.04440359, size.width * 0.9506150, size.height * 0.01903016);
    path_0.cubicTo(size.width * 0.9359150, 0, size.width * 0.9172750, 0, size.width * 0.8800000, 0);
    path_0.lineTo(size.width * 0.1200000, 0);
    path_0.cubicTo(size.width * 0.08272450, 0, size.width * 0.06408700, 0, size.width * 0.04938530,
        size.height * 0.01903016);
    path_0.cubicTo(size.width * 0.02978310, size.height * 0.04440359, size.width * 0.01420915,
        size.height * 0.09307219, size.width * 0.006089650, size.height * 0.1543291);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.006089650, size.height * 0.1543291);
    path_1.cubicTo(0, size.height * 0.2002719, 0, size.height * 0.2585141, 0, size.height * 0.3750000);
    path_1.cubicTo(0, size.height * 0.4914859, 0, size.height * 0.5497281, size.width * 0.006089650,
        size.height * 0.5956703);
    path_1.cubicTo(size.width * 0.01420915, size.height * 0.6569281, size.width * 0.02978310,
        size.height * 0.7055969, size.width * 0.04938530, size.height * 0.7309703);
    path_1.cubicTo(size.width * 0.06408700, size.height * 0.7500000, size.width * 0.08272450,
        size.height * 0.7500000, size.width * 0.1200000, size.height * 0.7500000);
    path_1.lineTo(size.width * 0.4381495, size.height * 0.7500000);
    path_1.cubicTo(size.width * 0.4414375, size.height * 0.7767703, size.width * 0.4477500,
        size.height * 0.8109375, size.width * 0.4566990, size.height * 0.8593750);
    path_1.cubicTo(size.width * 0.4718855, size.height * 0.9415750, size.width * 0.4794790,
        size.height * 0.9826750, size.width * 0.4897395, size.height * 0.9943469);
    path_1.cubicTo(size.width * 0.4963670, size.height * 1.001884, size.width * 0.5036350,
        size.height * 1.001884, size.width * 0.5102600, size.height * 0.9943469);
    path_1.cubicTo(size.width * 0.5205200, size.height * 0.9826750, size.width * 0.5281150,
        size.height * 0.9415750, size.width * 0.5433000, size.height * 0.8593750);
    path_1.cubicTo(size.width * 0.5522500, size.height * 0.8109375, size.width * 0.5585650,
        size.height * 0.7767703, size.width * 0.5618500, size.height * 0.7500000);
    path_1.lineTo(size.width * 0.8800000, size.height * 0.7500000);
    path_1.cubicTo(size.width * 0.9172750, size.height * 0.7500000, size.width * 0.9359150,
        size.height * 0.7500000, size.width * 0.9506150, size.height * 0.7309703);
    path_1.cubicTo(size.width * 0.9702150, size.height * 0.7055969, size.width * 0.9857900,
        size.height * 0.6569281, size.width * 0.9939100, size.height * 0.5956703);
    path_1.cubicTo(size.width, size.height * 0.5497281, size.width, size.height * 0.4914859, size.width,
        size.height * 0.3750000);
    path_1.cubicTo(size.width, size.height * 0.2585141, size.width, size.height * 0.2002719,
        size.width * 0.9939100, size.height * 0.1543291);
    path_1.cubicTo(size.width * 0.9857900, size.height * 0.09307219, size.width * 0.9702150,
        size.height * 0.04440359, size.width * 0.9506150, size.height * 0.01903016);
    path_1.cubicTo(size.width * 0.9359150, 0, size.width * 0.9172750, 0, size.width * 0.8800000, 0);
    path_1.lineTo(size.width * 0.1200000, 0);
    path_1.cubicTo(size.width * 0.08272450, 0, size.width * 0.06408700, 0, size.width * 0.04938530,
        size.height * 0.01903016);
    path_1.cubicTo(size.width * 0.02978310, size.height * 0.04440359, size.width * 0.01420915,
        size.height * 0.09307219, size.width * 0.006089650, size.height * 0.1543291);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffFAFAFA).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.006089650, size.height * 0.1543291);
    path_2.lineTo(size.width * -0.003149165, size.height * 0.1423703);
    path_2.lineTo(size.width * -0.003149165, size.height * 0.1423703);
    path_2.lineTo(size.width * 0.006089650, size.height * 0.1543291);
    path_2.close();
    path_2.moveTo(size.width * 0.006089650, size.height * 0.5956703);
    path_2.lineTo(size.width * -0.003149165, size.height * 0.6076297);
    path_2.lineTo(size.width * -0.003149165, size.height * 0.6076297);
    path_2.lineTo(size.width * 0.006089650, size.height * 0.5956703);
    path_2.close();
    path_2.moveTo(size.width * 0.04938530, size.height * 0.7309703);
    path_2.lineTo(size.width * 0.04555845, size.height * 0.7598406);
    path_2.lineTo(size.width * 0.04555845, size.height * 0.7598406);
    path_2.lineTo(size.width * 0.04938530, size.height * 0.7309703);
    path_2.close();
    path_2.moveTo(size.width * 0.4381495, size.height * 0.7500000);
    path_2.lineTo(size.width * 0.4474860, size.height * 0.7388031);
    path_2.lineTo(size.width * 0.4450230, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.4381495, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.4381495, size.height * 0.7500000);
    path_2.close();
    path_2.moveTo(size.width * 0.4566990, size.height * 0.8593750);
    path_2.lineTo(size.width * 0.4653590, size.height * 0.8437500);
    path_2.lineTo(size.width * 0.4653590, size.height * 0.8437500);
    path_2.lineTo(size.width * 0.4566990, size.height * 0.8593750);
    path_2.close();
    path_2.moveTo(size.width * 0.4897395, size.height * 0.9943469);
    path_2.lineTo(size.width * 0.4931595, size.height * 0.9649813);
    path_2.lineTo(size.width * 0.4897395, size.height * 0.9943469);
    path_2.close();
    path_2.moveTo(size.width * 0.5102600, size.height * 0.9943469);
    path_2.lineTo(size.width * 0.5068400, size.height * 0.9649813);
    path_2.lineTo(size.width * 0.5102600, size.height * 0.9943469);
    path_2.close();
    path_2.moveTo(size.width * 0.5433000, size.height * 0.8593750);
    path_2.lineTo(size.width * 0.5346400, size.height * 0.8437500);
    path_2.lineTo(size.width * 0.5346400, size.height * 0.8437500);
    path_2.lineTo(size.width * 0.5433000, size.height * 0.8593750);
    path_2.close();
    path_2.moveTo(size.width * 0.5618500, size.height * 0.7500000);
    path_2.lineTo(size.width * 0.5618500, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.5549750, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.5525150, size.height * 0.7388031);
    path_2.lineTo(size.width * 0.5618500, size.height * 0.7500000);
    path_2.close();
    path_2.moveTo(size.width * 0.9506150, size.height * 0.7309703);
    path_2.lineTo(size.width * 0.9467900, size.height * 0.7020984);
    path_2.lineTo(size.width * 0.9467900, size.height * 0.7020984);
    path_2.lineTo(size.width * 0.9506150, size.height * 0.7309703);
    path_2.close();
    path_2.moveTo(size.width * 0.9939100, size.height * 0.5956703);
    path_2.lineTo(size.width * 1.003150, size.height * 0.6076297);
    path_2.lineTo(size.width * 0.9939100, size.height * 0.5956703);
    path_2.close();
    path_2.moveTo(size.width * 0.9939100, size.height * 0.1543291);
    path_2.lineTo(size.width * 1.003150, size.height * 0.1423703);
    path_2.lineTo(size.width * 1.003150, size.height * 0.1423703);
    path_2.lineTo(size.width * 0.9939100, size.height * 0.1543291);
    path_2.close();
    path_2.moveTo(size.width * 0.9506150, size.height * 0.01903016);
    path_2.lineTo(size.width * 0.9467900, size.height * 0.04790125);
    path_2.lineTo(size.width * 0.9467900, size.height * 0.04790141);
    path_2.lineTo(size.width * 0.9506150, size.height * 0.01903016);
    path_2.close();
    path_2.moveTo(size.width * 0.04938530, size.height * 0.01903016);
    path_2.lineTo(size.width * 0.04555845, size.height * -0.009841125);
    path_2.lineTo(size.width * 0.04555845, size.height * -0.009841109);
    path_2.lineTo(size.width * 0.04938530, size.height * 0.01903016);
    path_2.close();
    path_2.moveTo(size.width * 0.01000000, size.height * 0.3750000);
    path_2.cubicTo(size.width * 0.01000000, size.height * 0.3163297, size.width * 0.01000540,
        size.height * 0.2738922, size.width * 0.01073800, size.height * 0.2403391);
    path_2.cubicTo(size.width * 0.01146445, size.height * 0.2070656, size.width * 0.01287245,
        size.height * 0.1848172, size.width * 0.01532845, size.height * 0.1662875);
    path_2.lineTo(size.width * -0.003149165, size.height * 0.1423703);
    path_2.cubicTo(size.width * -0.006782800, size.height * 0.1697844, size.width * -0.008419650,
        size.height * 0.1996281, size.width * -0.009215600, size.height * 0.2360844);
    path_2.cubicTo(size.width * -0.01000540, size.height * 0.2722578, size.width * -0.01000000,
        size.height * 0.3171844, size.width * -0.01000000, size.height * 0.3750000);
    path_2.lineTo(size.width * 0.01000000, size.height * 0.3750000);
    path_2.close();
    path_2.moveTo(size.width * 0.01532845, size.height * 0.5837125);
    path_2.cubicTo(size.width * 0.01287245, size.height * 0.5651828, size.width * 0.01146445,
        size.height * 0.5429344, size.width * 0.01073800, size.height * 0.5096609);
    path_2.cubicTo(size.width * 0.01000540, size.height * 0.4761078, size.width * 0.01000000,
        size.height * 0.4336703, size.width * 0.01000000, size.height * 0.3750000);
    path_2.lineTo(size.width * -0.01000000, size.height * 0.3750000);
    path_2.cubicTo(size.width * -0.01000000, size.height * 0.4328156, size.width * -0.01000540,
        size.height * 0.4777422, size.width * -0.009215600, size.height * 0.5139156);
    path_2.cubicTo(size.width * -0.008419650, size.height * 0.5503719, size.width * -0.006782800,
        size.height * 0.5802156, size.width * -0.003149165, size.height * 0.6076297);
    path_2.lineTo(size.width * 0.01532845, size.height * 0.5837125);
    path_2.close();
    path_2.moveTo(size.width * 0.05321200, size.height * 0.7020984);
    path_2.cubicTo(size.width * 0.03606020, size.height * 0.6798969, size.width * 0.02243300,
        size.height * 0.6373125, size.width * 0.01532845, size.height * 0.5837125);
    path_2.lineTo(size.width * -0.003149165, size.height * 0.6076297);
    path_2.cubicTo(size.width * 0.005985300, size.height * 0.6765437, size.width * 0.02350600,
        size.height * 0.7312953, size.width * 0.04555845, size.height * 0.7598406);
    path_2.lineTo(size.width * 0.05321200, size.height * 0.7020984);
    path_2.close();
    path_2.moveTo(size.width * 0.1200000, size.height * 0.7187500);
    path_2.cubicTo(size.width * 0.1012255, size.height * 0.7187500, size.width * 0.08764550,
        size.height * 0.7187328, size.width * 0.07690800, size.height * 0.7164438);
    path_2.cubicTo(size.width * 0.06626100, size.height * 0.7141734, size.width * 0.05914150,
        size.height * 0.7097734, size.width * 0.05321200, size.height * 0.7020984);
    path_2.lineTo(size.width * 0.04555845, size.height * 0.7598406);
    path_2.cubicTo(size.width * 0.05433100, size.height * 0.7711969, size.width * 0.06388100,
        size.height * 0.7763109, size.width * 0.07554700, size.height * 0.7787984);
    path_2.cubicTo(size.width * 0.08712250, size.height * 0.7812672, size.width * 0.1014990,
        size.height * 0.7812500, size.width * 0.1200000, size.height * 0.7812500);
    path_2.lineTo(size.width * 0.1200000, size.height * 0.7187500);
    path_2.close();
    path_2.moveTo(size.width * 0.4381495, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.1200000, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.1200000, size.height * 0.7812500);
    path_2.lineTo(size.width * 0.4381495, size.height * 0.7812500);
    path_2.lineTo(size.width * 0.4381495, size.height * 0.7187500);
    path_2.close();
    path_2.moveTo(size.width * 0.4653590, size.height * 0.8437500);
    path_2.cubicTo(size.width * 0.4562200, size.height * 0.7942828, size.width * 0.4504205,
        size.height * 0.7626984, size.width * 0.4474860, size.height * 0.7388031);
    path_2.lineTo(size.width * 0.4288135, size.height * 0.7611969);
    path_2.cubicTo(size.width * 0.4324545, size.height * 0.7908422, size.width * 0.4392795,
        size.height * 0.8275922, size.width * 0.4480385, size.height * 0.8750000);
    path_2.lineTo(size.width * 0.4653590, size.height * 0.8437500);
    path_2.close();
    path_2.moveTo(size.width * 0.4931595, size.height * 0.9649813);
    path_2.cubicTo(size.width * 0.4909100, size.height * 0.9624219, size.width * 0.4879145,
        size.height * 0.9555578, size.width * 0.4831770, size.height * 0.9350297);
    path_2.cubicTo(size.width * 0.4784655, size.height * 0.9146141, size.width * 0.4730625,
        size.height * 0.8854453, size.width * 0.4653590, size.height * 0.8437500);
    path_2.lineTo(size.width * 0.4480385, size.height * 0.8750000);
    path_2.cubicTo(size.width * 0.4555220, size.height * 0.9155047, size.width * 0.4615085,
        size.height * 0.9479875, size.width * 0.4669555, size.height * 0.9715891);
    path_2.cubicTo(size.width * 0.4723765, size.height * 0.9950797, size.width * 0.4783080,
        size.height * 1.014600, size.width * 0.4863190, size.height * 1.023711);
    path_2.lineTo(size.width * 0.4931595, size.height * 0.9649813);
    path_2.close();
    path_2.moveTo(size.width * 0.5068400, size.height * 0.9649813);
    path_2.cubicTo(size.width * 0.5024200, size.height * 0.9700062, size.width * 0.4975780,
        size.height * 0.9700062, size.width * 0.4931595, size.height * 0.9649813);
    path_2.lineTo(size.width * 0.4863190, size.height * 1.023711);
    path_2.cubicTo(size.width * 0.4951560, size.height * 1.033762, size.width * 0.5048450,
        size.height * 1.033762, size.width * 0.5136800, size.height * 1.023711);
    path_2.lineTo(size.width * 0.5068400, size.height * 0.9649813);
    path_2.close();
    path_2.moveTo(size.width * 0.5346400, size.height * 0.8437500);
    path_2.cubicTo(size.width * 0.5269400, size.height * 0.8854453, size.width * 0.5215350,
        size.height * 0.9146141, size.width * 0.5168250, size.height * 0.9350297);
    path_2.cubicTo(size.width * 0.5120850, size.height * 0.9555578, size.width * 0.5090900,
        size.height * 0.9624219, size.width * 0.5068400, size.height * 0.9649813);
    path_2.lineTo(size.width * 0.5136800, size.height * 1.023711);
    path_2.cubicTo(size.width * 0.5216900, size.height * 1.014600, size.width * 0.5276250,
        size.height * 0.9950797, size.width * 0.5330450, size.height * 0.9715891);
    path_2.cubicTo(size.width * 0.5384900, size.height * 0.9479859, size.width * 0.5444800,
        size.height * 0.9155047, size.width * 0.5519600, size.height * 0.8750000);
    path_2.lineTo(size.width * 0.5346400, size.height * 0.8437500);
    path_2.close();
    path_2.moveTo(size.width * 0.5525150, size.height * 0.7388031);
    path_2.cubicTo(size.width * 0.5495800, size.height * 0.7626984, size.width * 0.5437800,
        size.height * 0.7942828, size.width * 0.5346400, size.height * 0.8437500);
    path_2.lineTo(size.width * 0.5519600, size.height * 0.8750000);
    path_2.cubicTo(size.width * 0.5607200, size.height * 0.8275922, size.width * 0.5675450,
        size.height * 0.7908422, size.width * 0.5711850, size.height * 0.7611969);
    path_2.lineTo(size.width * 0.5525150, size.height * 0.7388031);
    path_2.close();
    path_2.moveTo(size.width * 0.8800000, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.5618500, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.5618500, size.height * 0.7812500);
    path_2.lineTo(size.width * 0.8800000, size.height * 0.7812500);
    path_2.lineTo(size.width * 0.8800000, size.height * 0.7187500);
    path_2.close();
    path_2.moveTo(size.width * 0.9467900, size.height * 0.7020984);
    path_2.cubicTo(size.width * 0.9408600, size.height * 0.7097734, size.width * 0.9337400,
        size.height * 0.7141734, size.width * 0.9230900, size.height * 0.7164438);
    path_2.cubicTo(size.width * 0.9123550, size.height * 0.7187328, size.width * 0.8987750,
        size.height * 0.7187500, size.width * 0.8800000, size.height * 0.7187500);
    path_2.lineTo(size.width * 0.8800000, size.height * 0.7812500);
    path_2.cubicTo(size.width * 0.8985000, size.height * 0.7812500, size.width * 0.9128750,
        size.height * 0.7812672, size.width * 0.9244550, size.height * 0.7787984);
    path_2.cubicTo(size.width * 0.9361200, size.height * 0.7763109, size.width * 0.9456700,
        size.height * 0.7711969, size.width * 0.9544400, size.height * 0.7598406);
    path_2.lineTo(size.width * 0.9467900, size.height * 0.7020984);
    path_2.close();
    path_2.moveTo(size.width * 0.9846700, size.height * 0.5837125);
    path_2.cubicTo(size.width * 0.9775650, size.height * 0.6373125, size.width * 0.9639400,
        size.height * 0.6798969, size.width * 0.9467900, size.height * 0.7020984);
    path_2.lineTo(size.width * 0.9544400, size.height * 0.7598406);
    path_2.cubicTo(size.width * 0.9764950, size.height * 0.7312953, size.width * 0.9940150,
        size.height * 0.6765437, size.width * 1.003150, size.height * 0.6076297);
    path_2.lineTo(size.width * 0.9846700, size.height * 0.5837125);
    path_2.close();
    path_2.moveTo(size.width * 0.9900000, size.height * 0.3750000);
    path_2.cubicTo(size.width * 0.9900000, size.height * 0.4336703, size.width * 0.9899950,
        size.height * 0.4761078, size.width * 0.9892600, size.height * 0.5096609);
    path_2.cubicTo(size.width * 0.9885350, size.height * 0.5429344, size.width * 0.9871300,
        size.height * 0.5651828, size.width * 0.9846700, size.height * 0.5837125);
    path_2.lineTo(size.width * 1.003150, size.height * 0.6076297);
    path_2.cubicTo(size.width * 1.006785, size.height * 0.5802156, size.width * 1.008420,
        size.height * 0.5503719, size.width * 1.009215, size.height * 0.5139156);
    path_2.cubicTo(size.width * 1.010005, size.height * 0.4777422, size.width * 1.010000,
        size.height * 0.4328156, size.width * 1.010000, size.height * 0.3750000);
    path_2.lineTo(size.width * 0.9900000, size.height * 0.3750000);
    path_2.close();
    path_2.moveTo(size.width * 0.9846700, size.height * 0.1662875);
    path_2.cubicTo(size.width * 0.9871300, size.height * 0.1848172, size.width * 0.9885350,
        size.height * 0.2070656, size.width * 0.9892600, size.height * 0.2403391);
    path_2.cubicTo(size.width * 0.9899950, size.height * 0.2738922, size.width * 0.9900000,
        size.height * 0.3163297, size.width * 0.9900000, size.height * 0.3750000);
    path_2.lineTo(size.width * 1.010000, size.height * 0.3750000);
    path_2.cubicTo(size.width * 1.010000, size.height * 0.3171844, size.width * 1.010005,
        size.height * 0.2722578, size.width * 1.009215, size.height * 0.2360844);
    path_2.cubicTo(size.width * 1.008420, size.height * 0.1996281, size.width * 1.006785,
        size.height * 0.1697844, size.width * 1.003150, size.height * 0.1423703);
    path_2.lineTo(size.width * 0.9846700, size.height * 0.1662875);
    path_2.close();
    path_2.moveTo(size.width * 0.9467900, size.height * 0.04790141);
    path_2.cubicTo(size.width * 0.9639400, size.height * 0.07010313, size.width * 0.9775650,
        size.height * 0.1126881, size.width * 0.9846700, size.height * 0.1662875);
    path_2.lineTo(size.width * 1.003150, size.height * 0.1423703);
    path_2.cubicTo(size.width * 0.9940150, size.height * 0.07345609, size.width * 0.9764950,
        size.height * 0.01870406, size.width * 0.9544400, size.height * -0.009841141);
    path_2.lineTo(size.width * 0.9467900, size.height * 0.04790141);
    path_2.close();
    path_2.moveTo(size.width * 0.8800000, size.height * 0.03125000);
    path_2.cubicTo(size.width * 0.8987750, size.height * 0.03125000, size.width * 0.9123550,
        size.height * 0.03126687, size.width * 0.9230900, size.height * 0.03355625);
    path_2.cubicTo(size.width * 0.9337400, size.height * 0.03582656, size.width * 0.9408600,
        size.height * 0.04022641, size.width * 0.9467900, size.height * 0.04790125);
    path_2.lineTo(size.width * 0.9544400, size.height * -0.009841078);
    path_2.cubicTo(size.width * 0.9456700, size.height * -0.02119625, size.width * 0.9361200,
        size.height * -0.02631141, size.width * 0.9244550, size.height * -0.02879875);
    path_2.cubicTo(size.width * 0.9128750, size.height * -0.03126687, size.width * 0.8985000,
        size.height * -0.03125000, size.width * 0.8800000, size.height * -0.03125000);
    path_2.lineTo(size.width * 0.8800000, size.height * 0.03125000);
    path_2.close();
    path_2.moveTo(size.width * 0.1200000, size.height * 0.03125000);
    path_2.lineTo(size.width * 0.8800000, size.height * 0.03125000);
    path_2.lineTo(size.width * 0.8800000, size.height * -0.03125000);
    path_2.lineTo(size.width * 0.1200000, size.height * -0.03125000);
    path_2.lineTo(size.width * 0.1200000, size.height * 0.03125000);
    path_2.close();
    path_2.moveTo(size.width * 0.05321200, size.height * 0.04790141);
    path_2.cubicTo(size.width * 0.05914150, size.height * 0.04022641, size.width * 0.06626100,
        size.height * 0.03582656, size.width * 0.07690850, size.height * 0.03355625);
    path_2.cubicTo(size.width * 0.08764550, size.height * 0.03126687, size.width * 0.1012255,
        size.height * 0.03125000, size.width * 0.1200000, size.height * 0.03125000);
    path_2.lineTo(size.width * 0.1200000, size.height * -0.03125000);
    path_2.cubicTo(size.width * 0.1014990, size.height * -0.03125000, size.width * 0.08712250,
        size.height * -0.03126687, size.width * 0.07554700, size.height * -0.02879875);
    path_2.cubicTo(size.width * 0.06388100, size.height * -0.02631141, size.width * 0.05433100,
        size.height * -0.02119625, size.width * 0.04555845, size.height * -0.009841125);
    path_2.lineTo(size.width * 0.05321200, size.height * 0.04790141);
    path_2.close();
    path_2.moveTo(size.width * 0.01532845, size.height * 0.1662875);
    path_2.cubicTo(size.width * 0.02243300, size.height * 0.1126881, size.width * 0.03606020,
        size.height * 0.07010313, size.width * 0.05321200, size.height * 0.04790141);
    path_2.lineTo(size.width * 0.04555845, size.height * -0.009841109);
    path_2.cubicTo(size.width * 0.02350600, size.height * 0.01870406, size.width * 0.005985300,
        size.height * 0.07345609, size.width * -0.003149165, size.height * 0.1423703);
    path_2.lineTo(size.width * 0.01532845, size.height * 0.1662875);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffEEEEEE).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
