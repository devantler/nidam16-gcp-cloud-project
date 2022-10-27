export const getDbConnectionString = () => {
    if(process.env.NODE_ENV === 'production') {
        return `mongodb+srv://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@${process.env.MONGO_DB_NAME}.wk1qr.mongodb.net/?retryWrites=true&w=majority`
    } else {
        return `mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@mongo:27017/admin`
    }
}