import '../../../../utils/data_util.dart';
import '../bank/List_Bank_entity.dart';

class PaymentItem {
  PaymentItem({
    bool? fastTransfer,
    String? userNameBank,
    String? userNameInput,
    String? stk,
    num? amount = 0,
    String? numberBill,
    String? money,
    String? note,
    BankDetail? bankDetail,
  }) {
    _userNameBank = userNameBank;
    _userNameInput = userNameInput;
    _stk = stk;
    _note = note;
    _amount = amount;
    _money = money;
    _numberBill = numberBill;
    _fastTransfer = fastTransfer;
    _bankDetail = bankDetail;
  }

  String? _userNameBank;
  String? _userNameInput;
  String? _stk;
  String? _note;
  String? _money;
  num? _amount;
  String? _numberBill;
  bool? _fastTransfer;
  BankDetail? _bankDetail;

  String? get userNameFromSTK => (_userNameBank != null && _userNameBank!.isNotEmpty) ? _userNameBank : _userNameInput;

  String? get userNameBank => _userNameBank;

  String get stk => _stk ?? '';

  String get note => _note ?? '';

  String get money => _money ?? '';

  String? get noteNull => _note;

  num get amount => _amount ?? 0;

  String get getTotalAmount => formatCurrencyRaw(amount);

  String get numberBill => _numberBill ?? '';

  bool get fastTransfer => _fastTransfer ?? false;

  BankDetail? get bankDetail => _bankDetail;

  @override
  String toString() {
    return 'PaymentItem{userNameFromSTK:$userNameFromSTK , _userNameBank:$_userNameBank _userNameInput:$_userNameInput _stk: $_stk, _note: $_note, _amount: $_amount, _fastTransfer: $_fastTransfer, _bankDetail: $_bankDetail}';
  }

  updatePayment({bool? fastTransfer, String? userNameBank, String? userNameInput, String? stk, num? amount, String? numberBill, String? note, String? money, BankDetail? bankDetail}) {
    this._userNameBank = userNameBank ?? this._userNameBank;
    this._userNameInput = userNameInput ?? this._userNameInput;
    this._fastTransfer = fastTransfer ?? this._fastTransfer;
    this._stk = stk ?? this._stk;
    this._amount = amount ?? this._amount;
    this._money = money ?? this._money;
    this._numberBill = numberBill ?? this._numberBill;
    this._note = note ?? this._note;
    this._bankDetail = bankDetail ?? this._bankDetail;
  }
}
