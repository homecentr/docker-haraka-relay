const path = require("path");
const axios = require("axios");
const nodemailer = require("nodemailer");

const {
    DockerComposeEnvironment
} = require("testcontainers");

const {
    waitUntil
} = require('async-wait-until/dist/commonjs');


describe("MailRelay container should", () => {
    var mailRelayContainer;
    var smtpMockContainer;
    var composeEnvironment;

    beforeAll(async () => {
        const composeFilePath = path.resolve(__dirname, "..");

        composeEnvironment = await new DockerComposeEnvironment(composeFilePath, "docker-compose.yml")
            .withBuild()
            .up();

        mailRelayContainer = composeEnvironment.getContainer("haraka");
        smtpMockContainer = composeEnvironment.getContainer("smtp_mock");
    });

    afterAll(async () => {
        await composeEnvironment.down();
    });

    it("Send e-mail via SMTP relay", async () => {
        // Arrange
        const transporter = nodemailer.createTransport({
            host: 'localhost',
            port: mailRelayContainer.getMappedPort(2525),
            auth: {
                user: "user1",
                pass: "password1"
            },
            tls: {
                // to accept self-signed certificate for testing
                rejectUnauthorized: false
            }
        });

        // Act
        await transporter.sendMail({
            from: "sender@test.com",
            to: "recipient@example.com",
            subject: 'Test Email Subject',
            html: 'Example HTML Message Body'
        });

        // Assert
        const data = await waitUntil(async () => {
            const response = await axios.get(`http://localhost:${smtpMockContainer.getMappedPort(1080)}/api/emails`)

            if(response.data.length > 0) {
                return response.data
            }

            return false
        })

        expect(data[0].subject).toBe('Test Email Subject')
    });
})
