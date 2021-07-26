# NSObject

> The [root class](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/RootClass.html#//apple_ref/doc/uid/TP40008195-CH46-SW1) of most Objective-C class hierarchies, from which subclasses inherit a basic interface to the runtime system and the ability to behave as Objective-C objects.

* primary access point whereby other classes interact with the Objective-C runtime
* basic object behavior
* introspection: 메타데이터 조사 (객체의 클래스, 구현 메소드, 프로퍼티, 프로토콜 등의 객체 정보 등)
* memory management: 메모리 관리
* method invocation: 함수호출

![image](https://user-images.githubusercontent.com/60323625/126932561-b1fe6a80-ecb1-4848-8b57-a049dd091a79.png)





### NSObject를 상속받는 이유

`NSObject`를 상속받음으로 Objective-C 런타임의 동작을 위한 정보들이 자동으로 모든 클래스들에 포함되어 컴파일 된다.

따라서, objective-C에서는 모든 객체가 NSObject를 상속받은 클래스여야합니다.



그러나, 우리가 사용하는 swift는 이런 제한이 없다는 사실!!

why..?!





## Objective-C  runtime

[objc.h](https://opensource.apple.com/source/objc4/objc4-706/runtime/objc.h.auto.html)

```objective-c
/// An opaque type that represents an Objective-C class.
typedef struct objc_class *Class;

struct objc_class {
	Class isa;
	Class super_class;
	const char *name;
	long version;
	long info;
	long instance_size;
	struct objc_ivar_list *ivars;
	struct objc_method_list **methodLists;
	struct objc_cache *cache;
	struct objc_protocol_list *protocols;
};

/// Represents an instance of a class.
struct objc_object {
    Class isa  OBJC_ISA_AVAILABILITY;
};

/// A pointer to an instance of a class.
typedef struct objc_object *id;
```

* id 포인터를 통해 해당하는 객체에 접근할 수 있다. 

* isa 라고 정의된 클래스를 통해 해당 객체가 어떤 클래스인지 알 수 있다.

  

```objective-c
/// An opaque type that represents a method selector.
typedef struct objc_selector *SEL;
SEL aSel = @selector(sampleMethod); 

/// A pointer to the function of a method implementation. 
typedef void (*IMP)(void /* id, SEL, ... */ ); 
#else
typedef id (*IMP)(id, SEL, ...); 
```

* id를 리턴하고 (이때 id는 void)
* 메소드를 실행할 타겟, 셀렉터, 추가 파라미터 등을 입력으로 받는 매소드 포인터



갑분 옵씨...;;

자료를 읽다가 삼천포로 빠졌습니다...😅



그래서 결론은,

Objective-C의 클래스 선언을 컴파일 할 때 메타클래스(MetaClass)를 생성해서 처리를하게되며 

이때 메타클래스는 NSObject이다.

```objective-c
@interface EmptyClass : NSObject {

}
@end
```

```objc
struct objc_class {
    Class isa;

#if !__OBJC2__
    Class super_class                                        OBJC2_UNAVAILABLE;
    const char *name                                         OBJC2_UNAVAILABLE;
    long version                                             OBJC2_UNAVAILABLE;
    long info                                                OBJC2_UNAVAILABLE;
    long instance_size                                       OBJC2_UNAVAILABLE;
    struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
    struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
#endif
} 
```






