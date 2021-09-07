



# KeyPath

객체의 값을 직접 가져오지않고, Key 또는 KeyPath 를 이용해서 **간접적으로** 데이터를 가져오거나 수정하는 방법



# What is this

**- @State는 단일 view에 속하는 단순 프로퍼티에 사용하며 private 접근자를 붙여 사용한다.**
**- @ObservedObject는 여러 view에 속하는 복잡한 프로퍼티들에 사용하며 reference 타입을 사용할 때는 @ObservedObject를 사용해야 한다.**
**- @EnvironmentObject는 shared data와 같은, 앱 어디에서든 쓰일 수 있는 프로퍼티들에 사용한다.**



@State

**- @State는 String, Int, Bool 등 단순 로컬 프로퍼티에 적합하다.**
**- @State 프로퍼티는 해당 뷰에 종속된다. (+ private 접근 제한자)**
**- @State private var classInstance = referenceTypeObject() ➡ 불가, 클래스의 인스턴스를 값으로 사용하려면 반드시 @ObservedObject를 사용해야 한다.**

@ObservedObject

**
\- @ObservedObject는 커스텀 타입과 같이 복잡한 프로퍼티들에 적합하다.**
**- @ObservedObject는 여러 뷰에서 공유되는 데이터에 적합하다.**





# Self vs self



# Fill Fit ~~ , ContentMode

scaletofill scaletofit



### Geometry Reader



### easein, easeout, easeinout

