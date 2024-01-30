// composables配下に置くと、import無しで呼び出せる
// グローバルな状態として使用できる
import type { Ref } from "vue";
export const useTitle = () => {
  const title = useState("title", () => "Hello World!");
  const changeTitle = (title: Ref<string>) => (value: string) => {
    title.value = value;
  };
  return {
    title: readonly(title),
    changeTitle: changeTitle(title),
  };
};

// カウンターアプリ用
export const useCount = () => {
  const count = useState("count", () => 0);
  const addCount = (count: Ref<number>) => () => {
    count.value++;
  };
  const minusCount = (count: Ref<number>) => () => {
    if (count.value > 0) count.value--;
  };
  const reset = (count: Ref<number>) => () => {
    count.value = 0;
  };
  return {
    count: readonly(count),
    addCount: addCount(count),
    minusCount: minusCount(count),
    reset: reset(count),
  };
};
