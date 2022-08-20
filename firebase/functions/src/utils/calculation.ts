/** 合計値を計算する。 */
export const sum = (numbers: number[]): number => {
    let sum = 0
    numbers.forEach(function (e) {
        sum += e
    })
    return sum
}

/** 合計値を計算する。 */
export const average = (numbers: number[]): number => {
    return sum(numbers) / numbers.length
}
