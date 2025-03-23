import 'package:vinemas_v1/features/chat_bot/domain/enum/message_chat_enum.dart';

extension MessageChatExtension on MessageChatEnum {
  int toInt() {
    switch (this) {
      case MessageChatEnum.text:
        return 0;
      case MessageChatEnum.image:
        return 1;
      case MessageChatEnum.video:
        return 2;
      case MessageChatEnum.audio:
        return 3;
      case MessageChatEnum.file:
        return 4;
      case MessageChatEnum.location:
        return 5;
      case MessageChatEnum.sticker:
        return 6;
      case MessageChatEnum.contact:
        return 7;
      case MessageChatEnum.poll:
        return 8;
      case MessageChatEnum.system:
        return 9;
    }
  }

  static MessageChatEnum fromInt(int value) {
    switch (value) {
      case 0:
        return MessageChatEnum.text;
      case 1:
        return MessageChatEnum.image;
      case 2:
        return MessageChatEnum.video;
      case 3:
        return MessageChatEnum.audio;
      case 4:
        return MessageChatEnum.file;
      case 5:
        return MessageChatEnum.location;
      case 6:
        return MessageChatEnum.sticker;
      case 7:
        return MessageChatEnum.contact;
      case 8:
        return MessageChatEnum.poll;
      case 9:
        return MessageChatEnum.system;
      default:
        return MessageChatEnum.text;
    }
  }
}

extension MessageChatSystemEnumExtension on MessageChatSystemEnum {
  int toInt() {
    switch (this) {
      case MessageChatSystemEnum.showtimesToday:
        return 0;
      case MessageChatSystemEnum.nearestCinema:
        return 1;
      case MessageChatSystemEnum.ticketPricePromo:
        return 2;
      case MessageChatSystemEnum.fastBooking:
        return 3;
      case MessageChatSystemEnum.paymentMethods:
        return 4;
    }
  }

  static MessageChatSystemEnum fromInt(int value) {
    switch (value) {
      case 0:
        return MessageChatSystemEnum.showtimesToday;
      case 1:
        return MessageChatSystemEnum.nearestCinema;
      case 2:
        return MessageChatSystemEnum.ticketPricePromo;
      case 3:
        return MessageChatSystemEnum.fastBooking;
      case 4:
        return MessageChatSystemEnum.paymentMethods;
      default:
        throw ArgumentError('Invalid MessageChatSystemEnum value: $value');
    }
  }
}
