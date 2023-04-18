export async function invoke(method, ...args) {
    return await fetch(
        `/invoke?method=${method}&args=${args == '' ? null : args.join('$')}`
    ).then((res) => {
        res.json()
    })
}
